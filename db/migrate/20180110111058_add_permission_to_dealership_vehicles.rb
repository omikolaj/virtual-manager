class AddPermissionToDealershipVehicles < ActiveRecord::Migration[5.1]
  def change
    add_column :dealership_vehicles, :permission, :integer
  end
end
