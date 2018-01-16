class Vehicle < ApplicationRecord
    belongs_to :dealership_vehicle
    has_one :dealership, :through => :dealership_vehicle

    # has_one :dealership_vehicles
    # delegate :dealership, :to => :dealershp_vehicles  
    # has_many :dealership_vehicles
    # has_many :dealerships, through: :dealership_vehicles  
    validates :model, :make, :year, :presence => :true
    validates_associated :dealership_vehicle, {message: "must have a buyer and price"}

    def dealership_vehicle_attributes=(dealership_vehicles_attributes)
        self.dealership = Dealership.find_by(:id => dealership_vehicles_attributes["dealership_id"].to_i)
        dealership_vehicle = DealershipVehicle.new(dealership_vehicles_attributes)
        if dealership_vehicle.save
            self.dealership_vehicle_id = dealership_vehicle.id
        end
    end
end
