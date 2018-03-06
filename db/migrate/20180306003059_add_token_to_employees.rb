class AddTokenToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :token, :string
  end
end
