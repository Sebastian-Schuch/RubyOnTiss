class UsersController < ApplicationController
  def new
    @user = User.new
    render :register
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully signed up'
    else
      render :register
    end
  end

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
