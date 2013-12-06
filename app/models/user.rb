class User < ActiveRecord::Base
  ROLES = %w[admin manager staff customer banned] 

  has_many :orders 
  belongs_to :branch 
        
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :role, :address, :expire_date, :phone, :name, :branch_id

  searchable do
    text  :name
    text  :phone
    text  :email
  end

  # attr_accessible :title, :body
end
