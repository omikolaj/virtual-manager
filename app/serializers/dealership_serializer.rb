class DealershipSerializer < ActiveModel::Serializer
  attributes :id, :name, :city
  has_many :vehicles
end
