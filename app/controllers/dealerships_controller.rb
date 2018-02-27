class DealershipsController < ApplicationController
  include DealershipHelper, EmployeesHelper, VehiclesHelper
	before_action :dealership, only: [:show, :edit, :update, :create, :destroy]
	before_action :require_login
    
    def index
      @dealerships = Dealership.all
      respond_to do |format|
        format.html {render :index}
        format.json {render json: @dealerships, status: 200}
      end
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
				else
					redirect_to @dealership
					flash[:notice] = "You must must be a manager to add new dealerships"
				end
			end
    end

    def create
      @dealership = Dealership.new(dealership_params)
      if @dealership.save
        redirect_to @dealership
        flash[:success] = "Dealership '#{@dealership.name}' has been successfully created!"
      else
        render :new
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
