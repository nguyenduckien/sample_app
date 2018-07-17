class SessionsController < ApplicationController
  def new; end

  def remember
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      SessionsController.remember
      redirect_to user
    else
      flash.now[:danger] = t("login_fail")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
