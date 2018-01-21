class DealershipsController < ApplicationController
    include DealershipHelper, EmployeesHelper
    before_action :dealership, only: [:show, :edit, :update, :create, :destroy]
    
    def index
        @dealerships = Dealership.all
    end

    def show
        
    end

		def new
				if !can_current_user?(:new, @@dealership = Dealership.new)
					raise params.inspect
				else
					@dealership = Dealership.new
					@dealership.vehicles.build
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
      if !can_current_user?(:destroy, @dealership)
          redirect_back fallback_location: @dealership
          flash[:notice] = "You cannot delete this dealerships"
      else
        employ_orphans(params[:id]) do 
          if last_dealership?
              redirect_back fallback_location: @dealership
              flash[:notice] = "Sorry you cannot delete last dealership" 
          else           
              @dealership.destroy
              flash[:notice] = "Dealership successfully deleted. All employees have been relocated to other locations"
              redirect_to dealerships_path
          end
        end
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
