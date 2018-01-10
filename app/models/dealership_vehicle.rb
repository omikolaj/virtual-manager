class DealershipVehicle < ApplicationRecord
    belongs_to :dealership
    belongs_to :vehicle
    
end
