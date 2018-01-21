class Dealership < ApplicationRecord
    has_many :dealership_vehicles
    has_many :vehicles, :through => :dealership_vehicles
    has_many :employees
    validates :name, :city, presence: true
    validates :name, uniqueness: true
    scope :id_array, -> {pluck(:id)}

    def self.all_except_current(dealership)
        self.all.reject{|o| o.name == dealership.name}
    end

    def vehicles_attributes=(vehicles_attributes)
        vehicles_attributes.each do |i, vehicle|
            self.vehicles.build(vehicle)
        end
    end

    def self.permissions_for(*args)
        methods = args
        methods.each do |method_name|
            define_method "#{method_name}able_by?" do |current_user|
                employee = self.employees.find_by(:id => current_user.id)
                if !employee
                    return false
                else
                    employee.send("#{method_name}able?")
                end
            end
        end
    end

    permissions_for :destroy, :edit, :new, :view

       
end
