class AddAsinToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :asin, :string
  end

  def self.down
    remove_column :items, :asin
  end
end
