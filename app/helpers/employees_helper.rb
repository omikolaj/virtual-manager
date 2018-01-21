module EmployeesHelper
    
    def employ_orphans(id)
        employees = Dealership.find_by(:id=> id).employees
        yield
        Employee.assign_employees_to_random_dealership(employees, current_user.id)
        update_current_user
    end

    def update_current_user
        current_user.dealership_id = Employee.current_user_new_dealership(current_user.id)
    end
end
