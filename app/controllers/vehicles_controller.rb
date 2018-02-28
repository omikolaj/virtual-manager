class VehiclesController < ApplicationController
  include VehiclesHelper
  before_action :vehicle, only: [:show, :edit, :update, :update, :destroy]
  before_action :new_vehicle, only: [:new]
  before_action :require_login

    def reports
      @dealership = Dealership.find_by(:id => params[:dealership_id]) unless params[:dealership_id] == 0
      @vehicles = generate_report_for(:id => params[:dealership_id], :type => params[:type])
    end

    def index
      @dealership = Dealership.find_by(:id => params[:dealership_id])
      @vehicles = @dealership.vehicles
			if !can_current_user?(:view, @dealership)
        redirect_back fallback_location: employee_path(current_user.id)
        flash[:notice] = "You cannot view vehicles. Check your permission levels"
      end
    end

    def show
      if !can_current_user?(:view, @vehicle)
        redirect_back fallback_location: employee_path(current_user.id)
        flash[:notice] = "You cannot view vehicles. Check your permission levels"
      end
      respond_to do |format|
        format.html {render :show}
        format.json {render json: @vehicle, status: 200}
      end
    end

		def new
      if !can_current_user?(:new, @vehicle)
        redirect_back fallback_location: dealership_path(@vehicle.dealership.id)
        flash[:notice] = "You cannot add vehicles. Check your permission levels"
      end
    end

    def create
      @vehicle = Vehicle.new(vehicle_params)       
      if @vehicle.save
        redirect_to dealership_vehicle_path(@vehicle.dealership.id, @vehicle)
        flash[:success] = "Vehicle has been successfully added"
      else
        render :new
      end
    end

    def edit
  		if !can_current_user?(:edit, @vehicle)
      	redirect_back fallback_location: dealership_vehicles_path(@vehicle.dealership.id)
      	flash[:notice] = "You cannot edit vehicles. Check your permission levels"
    	end		
  	end

    def update
      if @vehicle.update(vehicle_params)
        flash[:success] = "Vehicle Updated"
        redirect_to dealership_vehicle_path(@vehicle.dealership.id, @vehicle.id) 
      else
        render :edit
      end
    end

    def destroy
      if !can_current_user?(:destroy, @vehicle)
        redirect_back fallback_location: dealership_vehicle_path(@vehicle.dealership.id, @vehicle.id) 
        flash[:notice] = "You cannot delete this vehicle"
      else	
        @vehicle.destroy
        flash[:success] = "Vehicle successfully deleted"
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
