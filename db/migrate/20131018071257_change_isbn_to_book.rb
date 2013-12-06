class ChangeIsbnToBook < ActiveRecord::Migration
  def up

    rename_column :books, :isbn, :isbn_old
    add_column :books, :isbn, :bigint
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:isbn, book.isbn_old) }
    remove_column :books, :isbn_old

    
  end

  def down
  end
end
