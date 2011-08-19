class AddPicturePathToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :picture_path, :string
  end

  def self.down
    remove_column :items, :picture_path
  end
end
