module DealershipHelper

    def last_dealership?
        Dealership.all.size == 1
    end

end
