class DealershipVehicle < ApplicationRecord
    extend Permissions
    belongs_to :dealership
    has_many :vehicles
    validates :price, :buyer, :presence => true
    delegate :employees, :to => :dealership
    permissions_for :employees, :destroy, :edit, :view, :new
    
    def self.relocate(dealership_vehicles, dealership_id)
        dealership_vehicles.each do |dealership_vehicle|
            dealership_vehicle.update_attribute(:dealership_id, Dealership.id_array(dealership_id).sample)
        end
    end
    
    # def self.permissions_for(*args)
    #     association = args[0]
    #     methods = args[1..-1]
    #     methods.each do |method_name|
    #         define_method "#{method_name}able_by?" do |current_user|
    #                 employee = self.send(association).find_by(:id => current_user.id)
    #                 if !employee
    #                     return false
    #                 else
    #                     employee.send("#{method_name}able?")
    #                 end
                                
    #         end
    #     end
    # end

    

end
