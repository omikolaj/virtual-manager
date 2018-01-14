class EmployeesController < ApplicationController

    def omniauth
        @employee = Employee.find_existing_or_new_by_omniauth(current_user.id)
    end

    def index
        @employee = Employee.find_by(:id => current_user.id)
        @employees = @employee.dealership.employees
    end

    def show
        @employee = Employee.find_by(:id => params[:id])
        if @employee.new_with_omni?(params[:id])
            redirect_to edit_employee_path(@employee)
        else
            render :show
        end
    end

    def new
        @employee = Employee.new
    end
    
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            session[:user_id] = @employee.id
            
            redirect_to @employee
        else
            render :new
        end
    end

    def edit
        @employee = Employee.find_existing_or_new_by_omniauth(params[:id])
        #@employee = Employee.find_by(:id => params[:id])
    end

    def update
        @employee = Employee.find_existing_or_new_by_omniauth(params[:id])
        if @employee.update(employee_params)
            redirect_to @employee
            flash[:success] = "Profile Updated"
        else
            render :edit
        end
    end

    def destroy

    end

    private 
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :email, :password, :manager, :dealership_id)
    end
end
