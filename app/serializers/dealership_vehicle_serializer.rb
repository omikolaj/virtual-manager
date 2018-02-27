class DealershipVehicleSerializer < ActiveModel::Serializer
  belongs_to :dealership
  has_many :vehicles
  attributes :id


end
