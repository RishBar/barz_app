# frozen_string_literal: true

require 'test_helper'

class EmceesSignupTest < ActionDispatch::IntegrationTest  
  
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup' do
    get new_emcee_path
    assert_no_difference 'Emcee.count' do
      post emcees_path, params: { emcee: { name: 'fdsa',
                                           email: 'fdsainvalid.com',
                                           password: 'dude',
                                           password_confirmation: 'dude' } }
    end
    assert_template 'new'
  end

  test 'valid signup information' do
    get new_emcee_path
    assert_difference 'Emcee.count', 1 do
      post emcees_path, params: { emcee: { name: 'Example User',
                                           email: 'user@example.com',
                                           password: 'password123',
                                           password_confirmation: 'password123' } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    emcee = assigns(:emcee)
    assert_not emcee.activated?
    # Try to log in before activation.
    log_in_as(emcee)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: emcee.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(emcee.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(emcee.activation_token, email: emcee.email)
    assert emcee.reload.activated?
    follow_redirect!
    assert_template 'emcees/show'
    assert is_logged_in?
  end
end
