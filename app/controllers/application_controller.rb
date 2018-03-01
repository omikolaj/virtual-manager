class ApplicationController < ActionController::Base
  include SessionsHelper, ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login, :get_collections, only: [:home]
  skip_before_action :require_login, only: [:welcome]


  def welcome
    load_database
    redirect_to home_path if logged_in?
  end

  def home
    render :home if logged_in?
  end

  private
  def require_login
    redirect_to root_path unless logged_in?
  end

  def can_current_user?(action, object)
    object.send("#{action}able_by?", current_user)
  end

  def get_collections
    if logged_in?
      @dealerships = Dealership.all_except_current(current_user.dealership)
      @employees = Dealership.find_by(:id => current_user.dealership.id).employees
    end
  end

end
