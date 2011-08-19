class AddPointToProfessor < ActiveRecord::Migration
  def self.up
    add_column :professors, :point, :integer
  end

  def self.down
    remove_column :professors, :point
  end
end
