class Dealership < ApplicationRecord
    has_many :dealership_vehicles
    has_many :vehicles, :through => :dealership_vehicles
    has_many :employees
    validates :name, :city, presence: true
    validates :name, uniqueness: true

    def vehicles_attributes=(vehicles_attributes)
        vehicles_attributes.each do |i, vehicle|
            self.vehicles.build(vehicle)
        end
    end

    def self.lot_ready
       
    end

    def self.in_repair

    end

    

end
