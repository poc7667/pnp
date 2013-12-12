# encoding: utf-8
class Customer < ActiveRecord::Base
  
  include CartsHelper
  include ApplicationHelper

  attr_accessible :address, :comment, :email, :expire_date, :indoor_phone, :name, :phone, :role
  has_many :orders
  has_many :role_records

  after_save :sunspot_commit_reindex


  ROLES = %w[VIP PLATINUM] 
  
  DISC_BY_ROLE = {
    GENERAL: 1,
    VIP: 0.85,    
    PLATINUM: 0.79
  }
  
  CUSTOMER_TITLE ={
    PLATINUM: "白金",
    VIP: "VIP",
    GENERAL: "一般"
  }

  def self.get_guest
    self.find_by_name("GUEST")
  end

  def upgrade_role(action, order)
    #展期永遠從今天開始算
    binding.pry
    self.expire_date = 1.year.from_now.to_date.to_s
    self.role = :VIP.to_s if :join_vip == action
    self.role = :PLATINUM.to_s if :join_platinum == action

    # binding.pry
    # Skip the duplicated
    if RoleRecord.where(
     :customer_id => self.id,
     :role =>  self.role ,
     :order_id => order.id,
     :user_id => order.user.id

     ).count == 0

      role_record = RoleRecord.create(
                        customer_id: self.id ,
                        order_id: order.id,
                        expire_date: self.expire_date,
                        :user_id => order.user.id,
                        role: self.role 
                        )
      order.upgrade = role_record.id
      order.save()
      self.role_records << role_record
      self.save()    

    end


  end    

  def can_downgrade() #update role, 判斷是否過期
    # VERIFY BY CONSOLE
    # 把日期調整後，從網頁執行 看看
    
    #小心,一般vip 累積會員訂單的邏輯。如果延長的話，會不會導致有問題？
    #雖然VIP就是永久 但是也不需要延長了。
    #TODO:注意新增會員的地方是否 vip 自動延長了一年有效期限，有的話記得取消。
    if self.role.upcase == :PLATINUM.to_s.upcase
      if Date.parse(self.expire_date).past?
        downgraded_role = :VIP.to_s
        role_record = RoleRecord.create(
                          customer_id: self.id ,
                          expire_date: self.expire_date,
                          role: downgraded_role
                          )
        self.role_records << role_record
        self.role = downgraded_role
        self.save 

      end
    end
    return false
  end

  searchable do
    text  :phone    
    text  :name
    text  :email
  end

end