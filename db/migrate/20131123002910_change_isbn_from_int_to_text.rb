class ChangeIsbnFromIntToText < ActiveRecord::Migration
  def up

    # Change ISBN
    rename_column :books, :isbn, :isbn_old
    add_column :books, :isbn, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:isbn, book.isbn_old.to_s ) }
    remove_column :books, :isbn_old

  end

  def down
  end
end
