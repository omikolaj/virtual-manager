module SessionsHelper

    def log_in(user)
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= Employee.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def log_out
      session.delete(:user_id)
      session.delete(:developer)
      @current_user = nil
    end

    def logged_in_api?
      !!session[:token]
    end

    def authenticate_for_api
      session[:developer] = true
      redirect_to '/auth/github' unless logged_in_api?
    end

    def redirect_user
      if session[:developer]
        redirect_to developer_path
      else
        redirect_to root_path
      end
    end

end
