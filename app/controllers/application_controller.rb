class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, only: [:welcome]

  include SessionsHelper

  def welcome
    #Rails.application.load_seed = rake db:seed
    #Above method can be used to mimic API call to populate the database
    
    render :home if logged_in?
  end

  def require_login
    redirect_to root_path unless logged_in?
  end

end
