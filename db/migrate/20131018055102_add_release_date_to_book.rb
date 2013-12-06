class AddReleaseDateToBook < ActiveRecord::Migration
  def change
    add_column :books, :release_date, :text
  end
end
