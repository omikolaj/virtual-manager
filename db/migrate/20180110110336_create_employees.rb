class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :dealership_id
      t.boolean :omniauth, :default => false
      t.integer :uid

      t.timestamps
    end
  end
end
