module OrdersHelper
    def get_user_name(user_id)
        User.find_by_id(user_id).name  if user_id
    end
    def get_customer_name(customer_id)
        Customer.find_by_id(customer_id).name  if customer_id      
    end

    def get_books(order_id)
            # if order_id
    end

    def show_recent_ten_days() 
      return Date.today.downto(Date.today - 9.days)
    end

end
