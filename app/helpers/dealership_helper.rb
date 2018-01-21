module DealershipHelper

    def last_dealership?
        Dealership.all.size == 1
    end

    def can_dealership_be_deleted?
        if !can_current_user?(:destroy, @dealership)
            flash[:notice] = "You cannot delete this dealerships" 
        elsif !current_user.manager?
            flash[:notice] = "You must must be a manager to delete dealerships"
        elsif last_dealership?
            flash[:notice] = "Sorry you cannot delete last dealership"
        end
    end

end
