class AddRecommendToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :recommend, :boolean, :default => false
  end

  def self.down
    remove_column :items, :recommend
  end
end
