class Employee < ApplicationRecord
    belongs_to :employer, :class_name => "Dealership", :foreign_key => "dealership_id"
    belongs_to :dealership
    delegate :vehicles, :to => :dealership
    has_secure_password
    validates :first_name, :last_name, :username, :dealership_id, presence: true
    validates :username, uniqueness: true
    

end
