module DealershipHelper
    def employ_orphans(id)
        employees = Dealership.find_by(:id=> id).employees
        yield
        current_user.dealership_id = Employee.assign_employees_to_random_dealership(employees, current_user.id)
    end

    def last_dealership?
        Dealership.all.size == 1
    end

    def display_flash
        last_dealership? ? flash[:notice] = "Sorry you cannot delete last dealership" : flash[:notice] = "Dealership successfully deleted. All employees have been relocated to other locations"
    end
end
