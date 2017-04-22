class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :items
  # I am on the User table, I am looking for my purchases which is associated to
  # a buyer_id (who is a User) on the Order table
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  # I am on the User table, I am looking for my sales which is associated to a
  #seller_id (who is a User) on the Order table
  has_many :sales, class_name: "Order", foreign_key: "seller_id"

  after_create :assign_role

    def assign_role
      if user_type == 'Buyer'
        add_role :buyer
      elsif user_type == 'Seller'
        add_role :seller
      elsif user_type == 'Admin'
        add_role :admin
      end
    end

end
