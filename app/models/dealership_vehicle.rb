class DealershipVehicle < ApplicationRecord
    belongs_to :dealership
    has_many :vehicles
    
    validates :price, :buyer, :presence => true
    
end
