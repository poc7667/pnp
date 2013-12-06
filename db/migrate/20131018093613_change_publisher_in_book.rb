class ChangePublisherInBook < ActiveRecord::Migration
  def up

        # rename publisher
    rename_column :books, :publisher, :publisher_old
    add_column :books, :publisher, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:publisher, book.publisher_old) }
    remove_column :books, :publisher_old
    
  end

  def down
  end
end
