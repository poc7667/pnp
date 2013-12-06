class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :name
      t.integer :isbn
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
