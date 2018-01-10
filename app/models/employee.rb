class Employee < ApplicationRecord
    belongs_to :employer, :class_name => "Dealership", :foreign_key => "dealership_id"
    belongs_to :dealership
    delegate :vehicles, :to => :dealership
end
