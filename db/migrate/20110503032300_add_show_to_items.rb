class AddShowToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :show, :boolean, :default=>true
  end

  def self.down
    remove_column :items, :show
  end
end
