class AddSecondPriceToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :secondprice, :float
  end

  def self.down
    remove_column :items, :secondprice
  end
end
