class UsersController < ApplicationController
  before_action :already_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      # flash[:error] =
      render :new
    end
  end


  private

  def already_logged_in
    if logged_in?
      redirect_to cats_url
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
