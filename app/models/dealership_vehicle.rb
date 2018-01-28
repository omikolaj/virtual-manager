class DealershipVehicle < ApplicationRecord
    extend Permissions
    belongs_to :dealership
    has_many :vehicles
    validates :price, :buyer, :presence => true
    delegate :employees, :to => :dealership
    permissions_for :employees, :destroy, :edit, :view, :new
    
    def self.relocate(dealership_vehicles, dealership_id)
      dealership_vehicles.each do |dealership_vehicle|
      dealership_vehicle.update_attribute(:dealership_id, Dealership.id_array(dealership_id).sample)
        end
    end
    
end
