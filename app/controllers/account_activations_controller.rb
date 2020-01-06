class AccountActivationsController < ApplicationController
  def edit    
    emcee = Emcee.find_by(email: params[:email])
    if emcee && !emcee.activated? && emcee.authenticated?(:activation, params[:id])
      emcee.update_attribute(:activated,    true)
      emcee.update_attribute(:activated_at, Time.zone.now)
      log_in emcee
      flash[:success] = "Account activated!"
      redirect_to emcee
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end    
end
