class Branch < ActiveRecord::Base
  attr_accessible :address, :name, :phone
  has_many :users 
end
