class DealershipSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :vehicles
end
