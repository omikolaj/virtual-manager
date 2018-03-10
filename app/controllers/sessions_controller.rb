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
      github = GithubService.new
      session[:token] = github.authenticate!('Iv1.9e2102dc932faf05', 'e9e95e7a03feef361c1b117e439bc604ea0cc7ff', params[:code])
      redirect_to developer_path
      #user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      #user_json = JSON.parse(user_resp.body)
      #session[:username] = user_json["login"]         
    end

    def create
      if auth_hash = request.env["omniauth.auth"]
        if @employee = Employee.find_or_create_by_omniauth(auth_hash)
          log_in @employee          
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
