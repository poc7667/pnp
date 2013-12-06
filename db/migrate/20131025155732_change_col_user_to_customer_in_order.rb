class ChangeColUserToCustomerInOrder < ActiveRecord::Migration
  def up

    rename_column :orders, :user_id, :user_id_old
    add_column :orders, :customer_id, :bigint
    Order.reset_column_information
    Order.find(:all).each { |order| order.update_attribute(:customer_id, order.user_id_old) }
    remove_column :orders, :user_id_old


  end

  def down
  end
end
