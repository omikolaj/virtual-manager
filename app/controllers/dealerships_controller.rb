class DealershipsController < ApplicationController
    include DealershipHelper, EmployeesHelper, VehiclesHelper
    before_action :dealership, only: [:show, :edit, :update, :create, :destroy]
    
    def index
        @dealerships = Dealership.all
    end

    def show
			if !can_current_user?(:view, @dealership)
				redirect_back fallback_location: @dealership
				flash[:notice] = "You cannot view dealerships"
			end
    end

		def new
				if !can_current_user?(:new, @dealership = Dealership.new)
					redirect_back fallback_location: @dealership
					flash[:notice] = "You cannot add new dealerships"
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
            flash[:success] = "Dealership Created!"
        else
            render :new
        end
    end

    def edit
        if !can_current_user?(:edit, @dealership)
            redirect_back fallback_location: @dealership
            flash[:notice] = "You cannot edit dealerships"
        end
    end

    def update
        if @dealership.update(dealership_params)
            flash[:success] = "Dealershp Updated"
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
        flash[:notice] = "Dealership successfully deleted. All employees and assets have been relocated and redistributed"
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
