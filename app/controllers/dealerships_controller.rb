class DealershipsController < ApplicationController
    before_action :dealership, only: [:show, :edit, :update, :create, :destroy]

    def index
        @dealerships = Dealership.all
    end

    def show
        
    end

    def new
        @dealership = Dealership.new
        @dealership.vehicles.build
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
        @dealership.destroy
        redirect_to dealerships_path
    end

    private
    def dealership_params
        params.require(:dealership).permit(:name, :city, :vehicles_attributes => [:make, :model, :year])
    end

    def dealership
        @dealership = Dealership.find_by(:id => params[:id])
    end

    
end
