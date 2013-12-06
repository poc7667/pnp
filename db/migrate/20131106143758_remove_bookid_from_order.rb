class RemoveBookidFromOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :book_id
  end

  def down
    add_column :orders, :book_id, :int
  end
end
