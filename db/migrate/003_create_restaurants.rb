class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name, :null => false
      t.integer :city_id, :null => false
      t.integer :food_type_id
      t.integer :pricing
      t.decimal :rating, :precision => 2
      t.string :homepage, :null => false
      t.string :address, :null => false
      t.decimal :lat, :precision => 9, :scale => 6, :default => 0.0
      t.decimal :lon, :precision => 9, :scale => 6, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
