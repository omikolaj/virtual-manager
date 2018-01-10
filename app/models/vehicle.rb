class Vehicle < ApplicationRecord
    has_many :dealership_vehicles
    has_many :dealerships, through: :dealership_vehicles
    validates :model, :make, :year, presence: true
end
