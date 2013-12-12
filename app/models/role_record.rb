class RoleRecord < ActiveRecord::Base
  attr_accessible :customer_id, :expire_date, :role, :order_id, :user_id
  belongs_to :customer
  belongs_to :order
  belongs_to :user
  before_save :check_duplicate_upgrade
  # validates :, :presence => true, :uniqueness => {:scope => :wife}
  validates_uniqueness_of :customer_id, :scope => [:order_id, :created_at]
  private
  def check_duplicate_upgrade

  end
end
