class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :department
      t.string :course
      t.integer :section
      t.string :title
      t.string :isbn
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
