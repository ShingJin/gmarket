class AddConditionToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :condition, :integer
  end

  def self.down
    remove_column :items, :condition
  end
end
