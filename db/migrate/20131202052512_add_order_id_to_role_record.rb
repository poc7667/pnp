class AddOrderIdToRoleRecord < ActiveRecord::Migration
  def change
    add_column :role_records, :order_id, :integer
  end
end
