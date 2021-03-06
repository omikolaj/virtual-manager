module ApplicationHelper
    
  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
          "alert-danger"
      when "alert"
          "alert-block"
      when "notice"
          "alert-info"
      else
        flash_type.to_s
    end
  end

  private
  def load_database
    Rails.application.load_seed if check_dealerships
  end

  def check_dealerships
    database_empty ||= Dealership.all.size < 1
  end
  
end
