class AddIsbnToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :isbn, :string
  end

  def self.down
    remove_column :items, :isbn
  end
end
