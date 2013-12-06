class ChangeColumnLineItem < ActiveRecord::Migration
  def up


    rename_column :line_items, :cart_id, :cart_id_old
    add_column :line_items, :user_id, :int
    LineItem.reset_column_information
    LineItem.find(:all).each { |line_item| line_item.update_attribute(:user_id, line_item.cart_id_old) }
    remove_column :line_items, :cart_id_old

  end

  def down
  end
end
