class AddSubcategoryIdToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :subcategory_id, :integer
  end

  def self.down
    remove_column :items, :subcategory_id
  end
end
