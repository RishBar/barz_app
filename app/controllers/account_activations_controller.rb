class AccountActivationsController < ApplicationController
  def edit    
    emcee = Emcee.find_by(email: params[:email])
    if emcee && !emcee.activated? && emcee.authenticated?(:activation, params[:id])
      emcee.activate
      log_in emcee
      flash[:success] = "Account activated!"
      redirect_to emcee
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end    
end
