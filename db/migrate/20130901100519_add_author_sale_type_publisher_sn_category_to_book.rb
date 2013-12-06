class AddAuthorSaleTypePublisherSnCategoryToBook < ActiveRecord::Migration
    
  def change

      add_column :books, :author ,:text
      add_column :books, :sale_type, :text
      add_column :books, :publisher, :text
      add_column :books, :sn, :text
      add_column :books, :category, :text

      add_index :books, :sn
  end
end
