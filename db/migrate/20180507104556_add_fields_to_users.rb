class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false, default: "", :after => :id
    add_column :users, :last_name, :string, null: false, default: "", :after => :first_name
  end
end
