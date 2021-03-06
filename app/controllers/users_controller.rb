class UsersController < ApplicationController
  skip_before_action :authorized, only: [:sign_up, :create, :sign_in, :login]

  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && params[:user][:password] == params[:user][:password_confirmation]
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Login Success!!"
    else
      render :sign_up
    end
  end

  def sign_in
    @user = User.new
  end

  def login
    @user = User.login(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Login Success!!"
    else
      flash.now[:alert] = "email_or_password_invalid!!"
      render :sign_in
    end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to sign_in_users_path, notice: "sign_out_success!!"
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
