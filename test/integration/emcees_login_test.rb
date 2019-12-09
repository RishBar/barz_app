require 'test_helper'

class EmceesLoginTest < ActionDispatch::IntegrationTest

  def setup
    @emcee = emcees(:two)
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @emcee.email,
                                          password: 'password1234' } }
    assert_redirected_to @emcee
    follow_redirect!
    assert_template 'emcees/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", emcee_path(@emcee)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
