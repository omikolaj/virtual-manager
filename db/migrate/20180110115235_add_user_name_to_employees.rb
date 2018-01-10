class AddUserNameToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :username, :string
    add_column :employees, :password_digest, :string
  end
end
