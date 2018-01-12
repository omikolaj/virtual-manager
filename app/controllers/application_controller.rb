class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def welcome
    #Rails.application.load_seed = rake db:seed
    #Above method can be used to mimic API call to populate the database
  end

end
