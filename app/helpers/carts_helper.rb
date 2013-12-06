module CartsHelper
  require 'net/http'
  require 'pp'
  require "time"
  require 'pry'

  def get_discount(book, current_customer)

    @book, @current_customer = book, current_customer

    disc_by_role = Customer::DISC_BY_ROLE

    discounted =  disc_by_role[@current_customer.role.upcase.to_sym]
    if @book.sale_type == "fix_priced"
      return @book.price # return original price
    else
      # disc_book = disc_by_book_type[@book.sale_type.to_sym]
      return ( @book.price * discounted ).ceil.to_i
    end

  end

  def generate_nonexisted_book(price)
    
    # SALE_TYPE = normal, promotion, fixed_price
    # binding.pry
    modified_price = price.sub(/^0+/, "").downcase   # remove leading 0
    if modified_price.include? "s"
      modified_price = (modified_price.sub /^s/, '').to_i
      sale_type = "fix_priced"
    else
      modified_price = modified_price.to_i
      sale_type = "normal"
    end 

    last_book = Book.last

    @book = Book.new(:name => 'nil',
                     :price => modified_price ,
                     :sale_type => sale_type ,
                     :sn => last_book.sn.to_i+1,
                     :isbn => "1234567890" )


    if @book.save()
      return @book
    else
      generate_nonexisted_book
    end

  end


  def count_expire_time(expire_time)
    expire_time_utc = Time.parse(expire_time).getutc
    expired_in_days = ((expire_time_utc - Time.now.utc).to_i ) / 1.day
    return expired_in_days
  end


  def get_submitted_books_price(customer,
   order,
   books_ids=[])
  
    books = []

    #count total price
    sum_original_price = 0 
    sum_discounted_price = 0    

    books_ids.each  do |book_id|      
      book = Book.find_by_id(book_id)
      sum_discounted_price += get_discount( book,
                                          customer)
      sum_original_price += book.price 
      books << book 
    end

    order.original_amount = sum_original_price
    order.actual_amount = sum_discounted_price

    return books

  end

  def show_expiration_date

  end

end