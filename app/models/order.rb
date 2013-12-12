class Order < ActiveRecord::Base
  include OrdersHelper
  include ApplicationHelper
  attr_accessible :actual_amount,
                  :book_id, 
                  :original_amount, 
                  :role, 
                  :sn, 
                  :customer_id,
                  :user_id,
                  :created_at
  after_save :check_upgrade,:update_books, :sunspot_commit_reindex
  # has_many :line_items
  # has_many :books, :through => :line_items
  has_many :books
  has_many :role_records
  belongs_to :customer 
  belongs_to :user 

  before_destroy :restore_book

  THRESHOULD = {
    VIP: 500,
    PLATINUM: 20000
  }

  #
  scope :available, -> { where(order_id: nil).order('created_at DESC') }
  scope :not_available, where("order_id IS NOT NULL ")


  def self.recent(before_that_time)
   @recent_orders = self.where("created_at >= ?", before_that_time)
  end

  def self.by_day_branch( day_end, branch)
    
    day_start = day_end.midnight
    day_end = day_start + 1.day

    # day_start = Date.strptime(day_start, "%m/%d/%Y").midnight
    # day_end = day_start + 1.day

    ap [day_end, day_start]
    orders = self.where(["created_at >= ? AND created_at <= ?",
                day_start,
                day_end])
    ap orders.count
    orders_by_branch = orders.select{ |order|
      order.user.branch_id == branch
    }
    ap orders_by_branch.count
    # binding.pry
    return orders_by_branch
  end

  def self.sum(orders)
    summary = orders.inject(0) do | summary , order|
        summary += order.actual_amount.to_i
    end
  end


# 會員資格修改如下：
# 單次消費滿500元，即可加入一般會員。(無須累積也無年限)
# 若一年消費累積滿20000元，即升級為白金會員。
# (每年都需累積2萬，若無則降回一般會員)
  
  def self.get_points(customer)
    #累積會員一年內消費
    return 0 if customer.name == "GUEST"

    # orders = customer.orders.order("created_at DESC")

    orders = customer.orders
            .order("created_at DESC")
            .where(" created_at >= ?",
             1.year.ago)
            .all

    points = orders.inject(0) do |sum, order |
      break sum unless order.upgrade.nil?      
      sum += order.actual_amount || 0
    end

    points =0 if nil == points
    if nil == points
      points = 0
      binding.pry
    end

    return points
  end

  def check_upgrade(in_customer=nil)
    
    customer = in_customer || Customer.find_by_id(self.customer_id)
    return false if customer.name == "GUEST"
    role = customer.role.upcase

    points = Order.get_points(customer)

    check_data={
      customer: customer,
      order: self,
      points: points
    }

    if [:general.to_s.upcase] == role
      if points >= THRESHOULD[:VIP] #500
        customer.upgrade_role(:join_vip, self)
        ap("Enter General upgrade")
      end
    end

    # APPLY FOR ALL KIND OF CUSTOMER
    if points >= THRESHOULD[:PLATINUM] #20,000
        ap("Enter PLATINUM upgrade")
      customer.upgrade_role(:join_platinum, self)
    end
    # binding.pry

  end

  private

  def update_books
    self.books.each do |book|
      book.order_id = self.id
      book.save 
    end
  end
  def restore_book
    self.books.each do |book|
      book.order_id = nil
      book.save 
    end
    
  end


end
