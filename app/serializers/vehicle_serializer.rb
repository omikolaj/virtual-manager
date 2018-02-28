class VehicleSerializer < ActiveModel::Serializer
  belongs_to :dealership_vehicle
  has_one :dealership, :through => :dealership_vehicle
  attributes :id, :model, :make, :year
end
