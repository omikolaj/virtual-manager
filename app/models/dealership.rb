class Dealership < ApplicationRecord
    has_many :dealership_vehicles
    has_many :vehicles, through: :dealership_vehicles
    has_many :employees
end
