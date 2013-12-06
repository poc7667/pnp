class AddEmailUsernamePhoneIndoorPhoneExpirationToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :text
    add_column :users, :indoor_phone, :text
    add_column :users, :expire_date, :timestamp
  end
end
