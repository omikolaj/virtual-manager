class DealershipsController < ApplicationController

    def index
        @dealerships = Dealership.all
    end

    def show
        @dealership = Dealership.find_by(:id => params[:id])
    end

    def new
        @dealership = Dealership.new
        @dealership.vehicles.build
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
        @dealership = Dealership.find_by(:id => params[:id])
    end

    def update
        @dealership = Dealership.find_by(:id => params[:id])
        if @dealership.update(dealership_params)
            flash[:success] = "Dealershp Updated"
            redirect_to @dealership
        else
            render :edit
        end
    end

    def destroy

    end

    private
    def dealership_params
        params.require(:dealership).permit(:name, :city, :vehicles_attributes => [:make, :model, :year])
    end

    
end
