class AddCustomFiledsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :username, :string
  	add_index :users, :username, unique: true
  	add_column :users, :expiration_date, :date
  end
end
