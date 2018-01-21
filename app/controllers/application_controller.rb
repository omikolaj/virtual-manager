class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, only: [:welcome]


  def welcome
    #Rails.application.load_seed = rake db:seed
    #Above method can be used to mimic API call to populate the database
    @dealerships = Dealership.all_except_current(current_user.dealership) if logged_in?
    render :home if logged_in?
  end

  private
  def require_login
    redirect_to root_path unless logged_in?
  end

  def can_current_user?(action, object)
    object.send("#{action}able_by?", current_user)
  end

end
