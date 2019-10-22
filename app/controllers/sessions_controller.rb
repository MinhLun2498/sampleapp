class SessionsController < ApplicationController
  def new; end

  def create
    sessions = params[:session]
    user = User.find_by email: sessions[:email].downcase
    if user&.authenticate(sessions[:password])
      log_in user
      sessions[:remember_me] == Settings.min1 ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "session.wrong"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
