class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@[^@]+\z/}
  validates :password, presence: true

  has_many :orders, dependent: :destroy
  has_many :fav_products, dependent: :destroy
  has_many :my_fav_products, through: :fav_products, source: :product
  has_one :cart
  has_secure_password

  def current_user
    User.find(session[:user_id])
  end

  def self.login(option)
    @user = User.find_by(email: option[:email])
    @user ? @user.authenticate(option[:password]) : nil
  end
end
