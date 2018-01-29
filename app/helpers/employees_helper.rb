module EmployeesHelper
    
    def employ_orphans(dealership_id)
      employees = Dealership.find_by(:id=> dealership_id).employees
      vehicles = Dealership.find_by(:id => dealership_id).dealership_vehicles
      relocate_employees(employees, dealership_id)
      relocate_assets(vehicles, dealership_id)
    end

    def relocate_employees(employees, dealership_id)
      Employee.assign_employees_to_random_dealership(employees, dealership_id)
    end

    def relocate_assets(vehicles, dealership_id)
      DealershipVehicle.relocate(vehicles, dealership_id)
    end

    def display_manager
      manager = ""
      current_user.dealership.employees.collect do |e|
        if manager.split.size >= 1 && e.manager == true
          manager += ", #{e.name}"
        elsif e.manager == true
          manager += "#{e.name}"
          end
        end
      manager
    end

    def current_user_permission
        Employee.get_permission_level(current_user.id)
    end

    def display_permission_for(user_id)
      Employee.display_permission_level(user_id)
    end

end
