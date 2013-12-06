class AddConfirmableToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :text
    add_index :users, :confirmation_token
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
  end
end
