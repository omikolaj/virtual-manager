class DealershipVehicleSerializer < ActiveModel::Serializer
  belongs_to :dealership
  has_many :vehicles
  attributes :buyer, :is_lot_ready, :price


end
