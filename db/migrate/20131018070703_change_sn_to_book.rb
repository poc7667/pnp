class ChangeSnToBook < ActiveRecord::Migration
  def up


    rename_column :books, :sn, :sn_old
    add_column :books, :sn, :bigint
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:sn, book.sn_old) }
    remove_column :books, :sn_old

  end

  def down
  end
end
