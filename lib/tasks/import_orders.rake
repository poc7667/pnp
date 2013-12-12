# encoding: UTF-8
desc "Create orders"
require 'pry'
require 'ap'

require "#{Rails.root}/app/helpers/carts_helper"
include CartsHelper

namespace :import do
  task :orders => :environment do
    # n_order = Random.rand(1000)
    n_order = 300
    
    def time_rand from = 0.0, to = Time.now
      Time.at(from.to_f + rand * (to.to_f - from.to_f))
    end

    def get_sample_book()
      book = Book.all.sample
      while book.order_id != nil
        book = Book.all.sample
        p "get a new random book"
      end
      return book if book.order_id == nil 
    end

    ap n_order

    1.step( n_order ) do | i |

     customers = Customer.first(3)
     customer = customers.sample
     clerk = User.all.sample 
     n_books = Random.rand(2) 
     books = []

     ap "Books #{n_books}"
     0.step( n_books ) do |i| 
      books << get_sample_book()
     end

     create_date = time_rand(1.week.ago)
     order = Order.new(customer_id: customer.id,
                       role: customer.role,
                       created_at: create_date
                      )
     
     import_books = get_submitted_books_price(customer,
                                       order,
                                      books.map{|book| book.id})

     order.books << import_books 
     # ap order.books
     # binding.pry
     customer.orders << order
     clerk.orders << order
     order.save 
     # ap order.books
     clerk.save
     customer.save


     if order.books.count == 0
      binding.pry
     end

     
    Sunspot.commit_if_dirty
    system("yes | bundle exec rake sunspot:reindex")

    end



  end

end
