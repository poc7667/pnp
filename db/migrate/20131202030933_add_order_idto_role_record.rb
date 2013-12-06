class AddOrderIdtoRoleRecord < ActiveRecord::Migration
  def up
     add_column :role_records, :user_id, :integer
  end

  def down
  end
end
