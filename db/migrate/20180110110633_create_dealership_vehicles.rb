class CreateDealershipVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :dealership_vehicles do |t|
      t.integer :dealership_id
      t.integer :vehicle_id
      t.boolean :is_lot_ready, :default => true
      t.string :buyer
      t.integer :price

      t.timestamps
    end
  end
end
