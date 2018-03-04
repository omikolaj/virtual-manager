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

  def valid(hash)
    #if hash does NOT include city, means we are only asking about Name input field validation
    obj = {}
    if !hash.include?("city")
      obj = validate_name_field(hash)
    else
      obj = validate_city_field(hash)
    end
  end

  def validate_name_field(hash)
    obj = {:name => false, :uniquness=>true}
    if hash[:name].size >= 2
      obj[:name] = true
    end
    if Dealership.find_by_name(params[:name])
      obj[:uniquness] = false
    end
    obj
  end

  def validate_city_field(hash)
    obj = {:city=>false}
    if hash[:city].size >= 2
      obj[:city] = true
    end
    obj
  end
end
