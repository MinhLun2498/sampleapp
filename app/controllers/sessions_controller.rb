class SessionsController < ApplicationController
  before_action :load_params, only: :create

  def new; end

  def create
    if @user&.authenticate @session_params[:password]
      if @user.activated?
        log_in @user
        session[:remember_me] == Settings.min1 ? remember(@user) : forget(@user)
        redirect_to @user
      else
        flash[:warning] = t "sessions.accountnot"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "sessions.wrong"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def load_params
    @session_params = params[:session]
    @user = User.find_by email: @session_params[:email].downcase
    return if @user

    flash.now[:danger] = t "users.create.invalid"
    render :new
  end
end
