class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :name
      t.text :email
      t.text :phone
      t.text :indoor_phone
      t.text :role
      t.text :expire_date
      t.text :address
      t.text :comment

      t.timestamps
    end
  end
end
