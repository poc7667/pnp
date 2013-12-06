class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :sn
      t.integer :user_id
      t.integer :book_id
      t.integer :original_amount
      t.integer :actual_amount
      t.text :role

      t.timestamps
    end
  end
end
