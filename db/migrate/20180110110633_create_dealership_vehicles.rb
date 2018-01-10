class CreateDealershipVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :dealership_vehicles do |t|
      t.integer :dealership_id
      t.integer :vehicle_id
      t.integer :lot_ready
      t.integer :in_repair

      t.timestamps
    end
  end
end
