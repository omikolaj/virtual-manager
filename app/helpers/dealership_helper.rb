module DealershipHelper

  def last_dealership?
    Dealership.all.size == 1
  end

  def dealership_cannot_be_deleted
    if !can_current_user?(:destroy, @dealership)
      return flash[:notice] = "You cannot delete this dealerships" 
    elsif !current_user.manager?
      return flash[:notice] = "You must must be a manager to delete dealerships"
    elsif last_dealership?
      return flash[:notice] = "Sorry you cannot delete last dealership"
    end
  end

  def return_errors(errors)
    hash = {}
    errors.map do |err|
      if err.include?("Name")
        hash[:name] = err
      elsif err.include?("City")
        hash[:city]= err
      end
    end
    hash        
  end

end
