class CreateFoodTypes < ActiveRecord::Migration
  def self.up
    create_table :food_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :food_types
  end
end
