class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.text :name
      t.text :address
      t.text :phone

      t.timestamps
    end
  end
end
