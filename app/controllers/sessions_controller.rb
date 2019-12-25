# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    emcee = Emcee.find_by(email: params.require(:session).permit(:email)[:email].downcase)
    if emcee&.authenticate(params.require(:session).permit(:password)[:password])
      log_in emcee
      params[:session][:remember_me] == '1' ? remember(emcee) : forget(emcee)
      redirect_to emcee
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
