class Employee < ApplicationRecord
    belongs_to :employer, :class_name => "Dealership", :foreign_key => "dealership_id", :optional => true
    belongs_to :dealership, :optional => true
    delegate :vehicles, :to => :dealership
    has_secure_password :validations => false
    validates :password, :length => {:within => 6..40}, :presence => true, unless: :omniauth
    validates :name, :dealership_id, presence: true
    validates :email, presence: true, uniqueness: true
    PERMISSIONS = {
        :destroy => 0,
        :edit => 10,
        :view => 20,
        :new => 30
    }

    def self.permissable(*args)
        args.each do |action|
            define_method "#{action}able?" do
                self.permission <= PERMISSIONS[action]
            end
        end
    end

    permissable :destroy, :edit, :view, :new

    def self.assign_employees_to_random_dealership(orphaned_employees, current_user_id)
        orphaned_employees.each do |employee|
            employee.update(:dealership_id => Dealership.id_array.sample)
        end
        Employee.find_by(:id => current_user_id).dealership.id
    end

    def self.find_or_create_by_omniauth(auth_hash)
        self.where(:uid => auth_hash["uid"]).first_or_create do |employee|
            employee.email = auth_hash["info"]["email"]
            employee.password = SecureRandom.hex
            employee.name = auth_hash["info"]["name"]
            employee.omniauth = true
            employee.dealership_id = 1
        end
    end

end
