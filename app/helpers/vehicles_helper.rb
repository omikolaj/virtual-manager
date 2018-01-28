module VehiclesHelper
    # type represents 0 or 1. In which case, 0 is false 1 is true. In repair is 0, Lot ready is 1.
    def generate_report_for(id:, type:)
      if id == "0"
        Vehicle.all_lot_ready?(type)
      else
        Vehicle.lot_ready?(id, type)
      end
    end

    def report_type
      params[:type] == "0" ? "Vehicles in repair" : "Lot ready vehicles"
		end
		
end
