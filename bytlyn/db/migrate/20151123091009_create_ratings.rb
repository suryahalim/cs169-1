class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating, null: false
      t.belongs_to :restaurant, index: true, foreign_key: true
      t.belongs_to :customer, index: true, foreign_key: true
    end
  end
end
