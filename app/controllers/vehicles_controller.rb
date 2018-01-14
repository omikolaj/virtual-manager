class VehiclesController < ApplicationController

    def index
        @dealership = Dealership.find_by(:id => params[:dealership_id])
        @vehicles = Vehicle.all
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
