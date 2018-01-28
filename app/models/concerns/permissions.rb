module Permissions
    extend ActiveSupport::Concern
      def permissions_for(*args)
        association = args[0]
        methods = args[1..-1]
        methods.each do |method_name|
        define_method "#{method_name}able_by?" do |current_user|
        employee = self.employees.find_by(:id => current_user.id)
          if !employee && method_name == :new && association == :dealership
            current_user.send("#{method_name}able?")
          elsif
            !employee && method_name == :view
            current_user.send("#{method_name}able?")
          elsif !employee
            return false
          else
            employee.send("#{method_name}able?")
            end
          end
        end
      end
        
      PERMISSIONS = {
        :destroy => 0,
        :new => 10,
        :edit => 20,
        :view => 30,
        :none => 40
      }

      def permissable(*args)
        args.each do |action|
          define_method "#{action}able?" do
            self.permission <= PERMISSIONS[action]
            end
          end
       end

    end

