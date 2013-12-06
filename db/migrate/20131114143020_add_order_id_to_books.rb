class AddOrderIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :order_id, :integer
  end
end
