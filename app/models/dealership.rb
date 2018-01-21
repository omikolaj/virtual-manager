class Dealership < ApplicationRecord
    extend Permissions
    has_many :dealership_vehicles
    has_many :vehicles, :through => :dealership_vehicles
    has_many :employees
    validates :name, :city, presence: true
    validates :name, uniqueness: true
    scope :id_array, ->(avoid) {
        pluck(:id).reject{|d| d == avoid.to_i }
    }
    permissions_for :dealership, :destroy, :edit, :view, :new

    def self.all_except_current(dealership)
        self.all.reject{|o| o.name == dealership.name}
    end

    def vehicles_attributes=(vehicles_attributes)
        vehicles_attributes.each do |i, vehicle|
            self.vehicles.build(vehicle)
        end
    end

    

       
end
