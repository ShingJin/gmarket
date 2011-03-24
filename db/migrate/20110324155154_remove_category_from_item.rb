class RemoveCategoryFromItem < ActiveRecord::Migration
  def self.up
	 remove_column :items, :category
  end

  def self.down
      add_column :items, :category, :integer
  end
end
