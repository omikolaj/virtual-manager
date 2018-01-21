class DealershipsController < ApplicationController
    include DealershipHelper
    before_action :dealership, only: [:show, :edit, :update, :create, :destroy]
    
    def index
        @dealerships = Dealership.all
    end

    def show
        
    end

    def new
        if !can_current_user?(:new, @dealership)
            redirect_back fallback_location: dealerships_path
            flash[:notice] = "You cannot edit dealerships"
        else
            @dealership = Dealership.new
            @dealership.vehicles.build
        end
    end

    def create
        if @dealership.update()
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
                @dealership.destroy unless last_dealership?
            end
            redirect_to dealerships_path
            display_flash
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
