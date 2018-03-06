class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

    def guest
      @employee = Employee.find_by(:id => 1)
      log_in @employee
      redirect_to root_path
    end

    def new

    end

    def api_create
      binding.pry
      resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: 'Iv1.9e2102dc932faf05', client_secret:  'e9e95e7a03feef361c1b117e439bc604ea0cc7ff', code: params[:code]}, {'Accept' => 'application/json'}
      
          auth_hash = JSON.parse(resp.body)
          session[:token] = auth_hash["access_token"]
          user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
          user_json = JSON.parse(user_resp.body)
          session[:username] = user_json["login"]
      
          redirect_to '/'
    end

    def create
      if auth_hash = request.env["omniauth.auth"]
        if @employee = Employee.find_or_create_by_omniauth(auth_hash)
          log_in @employee
          session[:token] = auth_hash["credentials"]["token"]          
          redirect_to root_path
        else
          flash.now[:danger] = "Email already exists"
          render :welcome
        end
      else #Normal Login
        @employee = Employee.find_by(:email => params[:sessions][:email].downcase)
        if @employee && @employee.authenticate(params[:sessions][:password])
          log_in @employee
          redirect_to root_path
        else
          flash.now[:error] = "Invalid email or password, please try again"
          render :new
        end
      end
    end

    def destroy
        log_out
        redirect_to root_url
    end

end
