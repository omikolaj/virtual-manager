class VehiclesController < ApplicationController
    include VehiclesHelper
    before_action :vehicle, only: [:show, :edit, :update, :update, :destroy]

    def reports
        @vehicles = generate_report_for(:id => params[:dealership_id], :type => params[:type])
    end

    def index
        @dealership = Dealership.find_by(:id => params[:dealership_id])
        @vehicles = @dealership.vehicles
    end

    def show
        
    end

    def new
        @vehicle = Vehicle.new
        @vehicle.build_dealership_vehicle(:dealership_id => params[:dealership_id])
        @dealership = Dealership.find_by(:id => params[:dealership_id])
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
        if @vehicle.update(vehicle_params)
            flash[:success] = "Vehicle Updated"
            redirect_to @vehicle
        else
            render :edit
        end
    end

    def destroy
        @vehicle.destroy
        redirect_to dealership_vehicles_path(@vehicle.dealership.id)
    end

    private
    def vehicle_params
        params.require(:vehicle).permit(:model, :make, :year, :dealership_vehicle_attributes => [:is_lot_ready, :buyer, :price, :dealership_id])
    end

    def vehicle
        @vehicle = Vehicle.find_by(:id => params[:id])
    end

end
