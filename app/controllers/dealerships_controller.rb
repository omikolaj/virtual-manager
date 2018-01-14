class DealershipsController < ApplicationController

    def index
        @dealerships = Dealership.all
    end

    def show
        @dealership = Dealership.find_by(:id => params[:id])
    end
end
