class EmployeeSerializer < ActiveModel::Serializer
  belongs_to :dealership  
  attributes :id, :name
end
