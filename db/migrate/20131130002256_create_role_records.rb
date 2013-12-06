class CreateRoleRecords < ActiveRecord::Migration
  def change
    create_table :role_records do |t|
      t.integer :customer_id
      t.text :role
      t.text :expired_date

      t.timestamps
    end
  end
end
