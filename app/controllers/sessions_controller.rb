class SessionsController < ApplicationController
  def new
    render :login
    flash.now[:alert] = 'Invalid name or password'
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.password == params[:password]
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid name or password'
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
