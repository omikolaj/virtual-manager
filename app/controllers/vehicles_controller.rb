class VehiclesController < ApplicationController

    def index
        @dealership = Dealership.find_by(:id => params[:dealership_id])
        @vehicles = @dealership.vehicles
    end

    def show

    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end
end
