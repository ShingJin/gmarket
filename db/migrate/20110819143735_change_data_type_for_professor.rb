class ChangeDataTypeForProfessor < ActiveRecord::Migration
  def self.up
	 change_table :professors do |t|
      t.change :description, :text 
    end
  end

  def self.down
	change_table :professors do |t|
      t.change :description, :text
    end
  end
end
