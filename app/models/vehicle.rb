class Vehicle < ApplicationRecord
    belongs_to :dealership_vehicle
    has_one :dealership, :through => :dealership_vehicle
    validates :model, :make, :year, :presence => :true
    validate do |vehicle|
        vehicle.dealership_vehicle.errors.full_messages.each do |msg|
            errors[:base] << "#{msg}"
        end
    end
    
    def dealership_vehicle_attributes=(dealership_vehicles_attributes)
        self.build_dealership_vehicle(dealership_vehicles_attributes)
        self.dealership = Dealership.find_by(:id => dealership_vehicles_attributes["dealership_id"].to_i)
    end
    
    def self.all_lot_ready?(boolean)
        joins(:dealership_vehicle).where("dealership_vehicles.is_lot_ready = ?","boolean")
    end

    def self.lot_ready?(id, boolean)
        joins(:dealership_vehicle).where("dealership_vehicles.dealership_id = ? AND dealership_vehicles.is_lot_ready = ?", id, boolean)
    end

end
