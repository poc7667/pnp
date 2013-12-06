class ChangeColumnUserToOrderLineItem < ActiveRecord::Migration
  def up

    rename_column :line_items, :user_id, :user_id_old
    add_column :line_items, :order_id, :int
    LineItem.reset_column_information
    LineItem.find(:all).each { |line_item| line_item.update_attribute(:order_id, line_item.user_id_old) }
    remove_column :line_items, :user_id_old

  end

  def down
  end
end
