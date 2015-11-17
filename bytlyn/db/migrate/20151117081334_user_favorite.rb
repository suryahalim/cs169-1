class UserFavorite < ActiveRecord::Migration
  def change
  	change_table :favorites do |t|
  	  t.integer :user_id, null: false
  	  t.integer :rest_id, null: false
  	end
  end
end
