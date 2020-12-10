class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@[^@]+\z/}
  validates :password, presence: true

  has_many :orders
  has_many :fav_products
  has_one :cart
  has_secure_password

  has_many :tasks, dependent: :destroy

  def current_user
    User.find(session[:user_id])
  end

  def self.login(option)
    @user = User.find_by(email: option[:email])
    @user ? @user.authenticate(option[:password]) : nil
  end
end
