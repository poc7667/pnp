# encoding: utf-8
class Book < ActiveRecord::Base
  attr_accessible :name, :isbn ,:price ,:comment ,:author ,:sale_type ,:publisher ,:sn ,:category
  attr_accessible :location, :category, :release_date
  validates_uniqueness_of :sn
  validates  :price,:sn,:name, :presence => true
  include ApplicationHelper

  after_save :sunspot_commit_reindex

  TYPE_TITLE={
    fix_priced: "特價書籍",
    normal: "一般書籍"
  }

  scope :available, -> { where(order_id: nil).order('created_at DESC') }
  scope :not_available, where("order_id IS NOT NULL ")


  # has_one :line_items
  # has_one :orders, :through => :line_items
  belongs_to :order 

  # before_destroy :ensure_not_referenced_by_any_line_item

  def self.search_by_sn(key)
    if key
      ap("key is #{key}")
      # find(:all, :conditions => ['sn LIKE ?', "%#{key}%"])
      # find(:all, :conditions => ['translate_str LIKE ?', "%#{key}%"])      
      find(:all, :conditions => ["sn = #{key}"])
    else
      return nil
    end
  end

  # We should add annoy book when checkout books not in database

  # Sunspot
  searchable do
    text  :name
    text  :author
    text  :comment
    text  :sale_type
    text  :category
    text  :isbn
  end

end