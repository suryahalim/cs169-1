class NotNullToAccount < ActiveRecord::Migration
  def change
    change_column :accounts, :email, :string, :null => false
    change_column :accounts, :rest, :boolean, :null => false
    change_column :accounts, :name, :string, :null => false
  end
end
