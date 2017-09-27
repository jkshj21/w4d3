class SessionsController < ApplicationController

  before_action :already_logged_in, except: :destroy

  def new
    @session_token = session[:session_token]
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to cats_url
    else
      # flash.now[:error]=sadasdsa
      render :new
    end
  end

  def destroy
    logout!
    redirect_to cats_url
  end

  private

  def already_logged_in
    if logged_in?
      redirect_to cats_url
    end
  end

end
