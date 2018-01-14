class Employee < ApplicationRecord
    belongs_to :employer, :class_name => "Dealership", :foreign_key => "dealership_id", :optional => true
    belongs_to :dealership, :optional => true
    delegate :vehicles, :to => :dealership
    has_secure_password :validations => false
    validates :password, :presence => true, :unless => :skip_password_validation, :length => {:within => 6..40}
    validates :first_name, :last_name, :dealership_id, presence: true, unless: :skip_validations
    validates :email, presence: true, unless: :skip_email_validation
    validates :email, uniqueness: true
    
    after_initialize :set_skip_validations_default

    attr_accessor :skip_validations, :skip_email_validation, :skip_password_validation

    def set_skip_validations_default
        @skip_validations ||= false
        @skip_email_validation ||= false
        @skip_password_validation ||= false
    end
    
    def self.find_or_create_by_omniauth(auth_hash)
        if employee = Employee.find_by(:email => auth_hash["info"]["email"]) 
            return employee
        else
            employee = Employee.new(:email => auth_hash["info"]["email"], :password => SecureRandom.hex)
            employee.skip_validations = true
            employee.save
            employee
        end
    end

    def self.find_existing_or_new_by_omniauth(id)
        employee = Employee.find_by(:id => id)
        employee.skip_email_validation = true && employee.skip_password_validation = true unless employee.try(:first_name) && employee.try(:last_name)
        employee
        # binding.pry
        # employee = Employee.find_by(:email => email).try(:first_name).try(:last_name)
        # employee = Employee.find_by(:email => email)
        # if employee = Employee.find_by(:email => email).try(:first_name).try(:last_name)
        #     employee.skip_all_validations = true
        # else
        #     return employee
        # end            
    end

    def new_with_omni?(id)
        employee = Employee.find_by(:id => id)
        employee.try(:first_name) && employee.try(:last_name) ? false : true
    end



    # def self.find_or_create_by_omniauth(auth_hash)
    #     oauth_email = auth_hash["omniauth.auth"]["info"]["email"]
    #     if employee = Employee.find_by(:email => oauth_email)
    #         return employee
    #     else
    #         employee = Employee.create(:email => oauth_email, :password => SecureRandom.hex)
    #     end
    # end

end
