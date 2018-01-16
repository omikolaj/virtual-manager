class VehiclesController < ApplicationController

    def index
        #create a scope method using ActiveRecord query selectors to only select vehiles assigned to this dealership
        @dealership = Dealership.find_by(:id => params[:dealership_id])
        @vehicles = @dealership.vehicles
    end

    def show

    end

    def new
        @vehicle = Vehicle.new
        @vehicle.build_dealership_vehicle(:dealership_id => params[:dealership_id])
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)
        if @vehicle.save
            redirect_to @vehicle
            flash[:success] = "Vehicle successfully added!"
        else
            render :new
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private
    def vehicle_params
        params.require(:vehicle).permit(:model, :make, :year, :dealership_vehicle_attributes => [:is_lot_ready, :buyer, :price, :dealership_id])
    end
end
