class DealershipsController < ApplicationController
  include DealershipHelper, EmployeesHelper, VehiclesHelper
	before_action :dealership, only: [:show, :edit, :update, :create, :destroy]
  before_action :require_login
    
    def validation
      render json: valid(params)
    end

    #resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: 'Iv1.9e2102dc932faf05', client_secret: #'e9e95e7a03feef361c1b117e439bc604ea0cc7ff', code: params[:code]}, {'Accept' => 'application/json'}
    
    def index
      binding.pry
      #obj = {}
      #binding.pry
      #redirect = CGI.escape("http://localhost:3000/api/github")
      #response1 = Faraday.get 'https://github.com/login/oauth/authorize', {client_id: 'Iv1.9e2102dc932faf05', redirect_uri: redirect}
      response = Faraday.post("https://api.github.com/repos/omikolaj/hello-world/issues") do |req|        
        req.params['oauth_token'] = session[:token]
        req.params["Accept"] = 'application/json'
        req.body = {:title => "mayu"}.to_json
      end
      #@repos_array = JSON.parse(response.body)
      #binding.pry      
      #@dealerships = Dealership.all
      #respond_to do |format|
        #format.html {render :index}
        #format.json {render json: @dealerships, status: 200}
      #end
      redirect_to "https://github.com/login/oauth/authorize?client_id=Iv1.9e2102dc932faf05&scope=repo"
    end

    def show
      if !can_current_user?(:view, @dealership)
				redirect_back fallback_location: employee_path(current_user.id)
				flash[:notice] = "You cannot view this dealerships. Check your permission levels"
			end
    end

		def new
		  if !can_current_user?(:new, @dealership = Dealership.new)
			  redirect_back fallback_location: @dealership
				flash[:notice] = "You cannot add new dealership. Are you a manager? Do you have 'New' permission level?"
			else
        if current_user.manager?
          @dealership = Dealership.new
          @dealership.vehicles.build
          respond_to do |format|
            format.html {render :new}
            format.json {render json: @dealership, status: 200}
          end         
				else
					redirect_to @dealership
					flash[:notice] = "You must must be a manager to add new dealerships"
				end
			end
    end

    def create
      @dealership = Dealership.new(dealership_params)
      if @dealership.save
        if request.format.json?
          render json: @dealership, status: 200
        else                        
          redirect_to @dealership
          flash[:success] = "Dealership '#{@dealership.name}' has been successfully created!"
        end
      else     
        render json: return_errors(@dealership.errors.full_messages)
      end
    end

    def edit
      if !can_current_user?(:edit, @dealership)
        redirect_back fallback_location: @dealership
        flash[:notice] = "You cannot edit dealerships. Check your permission levels"
      end
    end

    def update
      if @dealership.update(dealership_params)
        flash[:success] = "Dealership has been updated"
        redirect_to @dealership
      else
        render :edit
       end
    end

		def destroy
			if dealership_cannot_be_deleted
				redirect_back fallback_location: @dealership
			else
				employ_orphans(params[:id])        
        @dealership.destroy
        flash[:success] = "Dealership successfully deleted. All employees and assets have been relocated and redistributed"
        redirect_to dealerships_path
			end
		end
		
    private
    def dealership_params
      params.require(:dealership).permit(:name, :city, :vehicles_attributes => [:make, :model, :year])
    end

    def dealership
      @dealership = Dealership.find_by(:id => params[:id])
    end

end
