class EmployeesController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    
    
    def index
        @employees = Employee.find_by(:id => current_user.id).dealership.employees
        
    end

    def show
        @employee = Employee.find_by(:id => params[:id])
        render :show
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
            render :'new'
        end
    end

    def edit
        @employee = Employee.find_by(:id => params[:id])
    end

    def update
        @employee = Employee.find_by(:id => params[:id])
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
        params.require(:employee).permit(:name, :email, :password, :manager, :dealership_id)
    end


end
