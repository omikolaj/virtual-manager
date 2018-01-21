class VehiclesController < ApplicationController
    include VehiclesHelper
    before_action :vehicle, only: [:show, :edit, :update, :update, :destroy]
    before_action :new_vehicle, only: [:new]

    def reports
        @vehicles = generate_report_for(:id => params[:dealership_id], :type => params[:type])
    end

    def index
        @dealership = Dealership.find_by(:id => params[:dealership_id])
        @vehicles = @dealership.vehicles
    end

    def show
        if !can_current_user?(:view, @vehicle)
            redirect_back fallback_location: @dealership
            flash[:notice] = "You cannot add vehicle"
        end
    end

    def new
        if !can_current_user?(:new, @vehicle)
            redirect_back fallback_location: @dealership
            flash[:notice] = "You cannot add vehicle"
        end
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
        if !can_current_user?(:edit, @vehicle)
            redirect_back fallback_location: @dealership
            flash[:notice] = "You cannot edit this vehicle"
        end		
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
        if !can_current_user?(:destroy, @vehicle)
            redirect_back fallback_location: @vehicle
            flash[:notice] = "You cannot delete this vehicle"
        else	
            @vehicle.destroy
        end
        redirect_to dealership_vehicles_path(@vehicle.dealership.id) unless performed?
    end

    private
    def vehicle_params
        params.require(:vehicle).permit(:model, :make, :year, :dealership_vehicle_attributes => [:is_lot_ready, :buyer, :price, :dealership_id])
    end

    def vehicle
        @vehicle = Vehicle.find_by(:id => params[:id])
    end
    
    def new_vehicle
        @vehicle = Vehicle.new
        @vehicle.build_dealership_vehicle(:dealership_id => params[:dealership_id])
        @dealership = Dealership.find_by(:id => params[:dealership_id])
    end

end
