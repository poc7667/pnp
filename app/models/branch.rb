# encoding: utf-8
class Branch < ActiveRecord::Base
  attr_accessible :address, :name, :phone
  has_many :users 
  LIST = [
    "人文館",
    "博雅館"
  ]
end
