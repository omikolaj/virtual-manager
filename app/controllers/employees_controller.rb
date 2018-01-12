class EmployeesController < ApplicationController

    def index

    end

    def show
        @employee = Employee.find_by(:id => params[:id])
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
        @employee = Employee.find_by(:id => params[:id])
    end

    def update

    end

    def destroy

    end

    private 
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :username, :password, :manager, :dealership_id)
    end
end
