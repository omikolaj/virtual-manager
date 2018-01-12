class SessionsController < ApplicationController

    def new
    end

    def create
        user = Employee.find_by(:username => params[:sessions][:username].downcase)
        if user && user.authenticate(params[:sessions][:password])
            log_in user
            redirect_to user
        else
            flash.now[:danger] = "Invalid email or password, please try again."
            render :new
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end 
end
