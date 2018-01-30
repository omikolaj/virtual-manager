class EmployeesController < ApplicationController
  include EmployeesHelper
  before_action :require_login, :employee
  skip_before_action :require_login, only: [:new, :create]
    
    def permissions
      @employee = Employee.find_by(:id => params[:employee_id])
      if @employee.update_permissions(params[:permission_id])
        flash[:success] = "#{@employee.name}'s permission set to '#{display_permission_for(@employee.id)}'"
        redirect_to "#{root_path}#permission-updated"
      else
        flash[:error] = "Something went wrong..."
        render :home
      end
    end

    def index
      @employees = Employee.find_by(:id => current_user.id).dealership.employees        
    end

    def show
      render :show
    end

    def new
      @employee = Employee.new
    end
    
    def create
      @employee = Employee.new(employee_params)
      if @employee.save
        session[:user_id] = @employee.id          
        redirect_to root_path
      else
        render :'new'
      end
    end

    def edit

    end

    def update
      if @employee.update(employee_params)
        redirect_to @employee
        flash[:success] = "Profile successfully updated"
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

    def employee
      @employee = Employee.find_by(:id => params[:id])
    end
    
end
