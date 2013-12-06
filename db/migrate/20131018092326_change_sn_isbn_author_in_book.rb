class ChangeSnIsbnAuthorInBook < ActiveRecord::Migration
  def up

    # rename author
    rename_column :books, :author, :author_old
    add_column :books, :author, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:author, book.author_old) }
    remove_column :books, :author_old

    #rename sale_type
    rename_column :books, :sale_type, :sale_type_old
    add_column :books, :sale_type, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:sale_type, book.sale_type_old) }
    remove_column :books, :sale_type_old

    #name
    rename_column :books, :name, :name_old
    add_column :books, :name, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:name, book.name_old) }
    remove_column :books, :name_old

    #category
    rename_column :books, :category, :category_old
    add_column :books, :category, :text
    Book.reset_column_information
    Book.find(:all).each { |book| book.update_attribute(:category, book.category_old) }
    remove_column :books, :category_old

  end

  def down
  end
end
