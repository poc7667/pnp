class AddUpgradeColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :upgrade, :text
  end
end
