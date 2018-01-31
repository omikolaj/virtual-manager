class Employee < ApplicationRecord
    extend Permissions
    belongs_to :employer, :class_name => "Dealership", :foreign_key => "dealership_id", :optional => true
    belongs_to :dealership, :optional => true
    delegate :vehicles, :to => :dealership
    has_secure_password :validations => false
    validates :password, :length => {:within => 6..40}, :presence => true, unless: :omniauth
    validates :name, :dealership_id, presence: true
    validates :email, presence: true, uniqueness: true
    permissable :destroy, :edit, :view, :new

    def self.assign_employees_to_random_dealership(orphaned_employees, dealership_id)
      orphaned_employees.each do |employee|
      employee.update_attribute(:dealership_id, Dealership.id_array(dealership_id).sample)
      end
    end

    def self.find_or_create_by_omniauth(auth_hash)
      self.where(:uid => auth_hash["uid"]).first_or_create do |employee|
        employee.email = employee.set_github_email(auth_hash)
        employee.password = SecureRandom.hex
        employee.name = employee.set_github_name(auth_hash)
        employee.omniauth = true
        employee.dealership_id = 1
      end
    end

    def update_permissions(permission_id)
      self.update_attribute(:permission, permission_id)
    end

    def self.get_permission_level(id)
      employee = Employee.find_by(:id => id)
      Permissions::PERMISSIONS.invert[employee.permission].to_s        
    end

    def self.display_permission_level(user_id)
      employee = Employee.find_by(:id => user_id)
      Permissions::PERMISSIONS.invert[employee.permission].to_s 
    end

    def set_github_email(auth_hash)
      auth_hash["info"]["email"].nil? ? "#{auth_hash["info"]["nickname"]}@users.noreply.github.com" : auth_hash["info"]["email"]
    end

    def set_github_name(auth_hash)
      auth_hash["info"]["name"].nil? ? auth_hash["info"]["nickname"] : auth_hash["info"]["name"]
    end

end
