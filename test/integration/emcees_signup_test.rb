require 'test_helper'

class EmceesSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    get new_emcee_path
    assert_no_difference 'Emcee.count' do
      post emcees_path, params: { emcee: {name: 'fdsa',
                                 email:'fdsainvalid.com', 
                                 password:'dude', 
                                 password_confirmation:'dude'}}
    end 
    assert_template 'new'
  end

class EmceesSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    get new_emcee_path
    assert_difference 'Emcee.count', 1 do
      post emcees_path, params: { emcee: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password123",
                                         password_confirmation: "password123" } }
    end
    follow_redirect!
    assert_template 'show'
  end
end
require 'test_helper'
  
end
