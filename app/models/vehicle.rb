class Vehicle < ApplicationRecord
    has_many :dealership_vehicles
    has_many :dealerships, through: :dealership_vehicles
end
