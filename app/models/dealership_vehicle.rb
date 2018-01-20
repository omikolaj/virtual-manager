class DealershipVehicle < ApplicationRecord
    belongs_to :dealership
    has_many :vehicles
    validates :price, :buyer, :presence => true
    
    # Select * from vehicles inner join dealership_vehicles on vehicles.dealership_vehicle_id = dealership_vehicles.id where dealership_vehicles.is_lot_ready = false;

    # Select * from vehicles inner join dealership_vehicles on vehicles.dealership_vehicle_id = dealership_vehicles.id where dealership_vehicles.is_lot_ready = true;


end
