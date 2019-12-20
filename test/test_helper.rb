# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def is_logged_in?
    !session[:emcee_id].nil?
  end

  def log_in_as(emcee)
    session[:emcee_id] = emcee.id
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular emcee.
  def log_in_as(emcee, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: emcee.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end