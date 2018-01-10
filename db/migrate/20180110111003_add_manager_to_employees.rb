class AddManagerToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :manager, :boolean
  end
end
