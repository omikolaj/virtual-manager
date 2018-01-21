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


    # def employ_orphans(dealership_id)
    #     employees = Dealership.find_by(:id=> dealership_id).employees
    #     vehicles = Dealership.find_by(:id => dealership_id).dealership_vehicles
    #         yield
    #     Employee.assign_employees_to_random_dealership(employees, dealership_id)
    #     relocate_assets(vehicles) 
    # end

    # def relocate_assets(vehicles)
    #     DealershipVehicle.relocate(vehicles)
    # end

end
