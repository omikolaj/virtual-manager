class DealershipVehicle < ApplicationRecord
    belongs_to :dealership
    has_many :vehicles
    # belongs_to :dealership
    # belongs_to :vehicle
    validates :price, :buyer, :presence => true
    
end
