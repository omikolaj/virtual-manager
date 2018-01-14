class AddLotReadyToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_column :vehicles, :is_lot_ready, :boolean, :default => true
  end
end
