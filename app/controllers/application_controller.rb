class ApplicationController < ActionController::Base
  include SessionsHelper, ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login, :get_collections, only: [:home]
  before_action :authenticate_api_user, only:[:fork, :issues, :create_issue, :developer]
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

  def authenticate_api_user
    client_id = "Iv1.9e2102dc932faf05"
    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo"
    redirect_to github_url unless logged_in_api?
  end

end
