class LineItem < ActiveRecord::Base
  attr_accessible :book_id, :order_id
  belongs_to :book
  belongs_to :order

end
