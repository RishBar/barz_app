# frozen_string_literal: true

require 'test_helper'

class EmceesLoginTest < ActionDispatch::IntegrationTest
  def setup
    @emcee = emcees(:two)
  end

  test 'login with valid information followed byt logout' do
    get login_path
    post login_path, params: { session: { email: @emcee.email,
                                          password: 'password1234' } }
    assert_redirected_to @emcee
    follow_redirect!
    assert_template 'emcees/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', emcee_path(@emcee)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", emcee_path(@emcee), count: 0
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
