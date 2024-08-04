class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    @user = User.new(user)
    if @user.save
      session[:user_id] = @user.id
      render json: User.create(user)
    else
      render json: { data: { error: 'Invalid Email or Password' } }, status: 400
    end
  end

  def login
    user = user_params
    @user = User.find_by(email: user[:email])
    if @user.authenticate(user[:password])
      render json: @user
    else
      render json: { data: { error: 'Incorrect Email or Password' } }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
