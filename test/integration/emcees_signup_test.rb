require 'test_helper'

class EmceesSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    get new_emcee_path
    assert_no_difference 'Emcee.count' do
      post emcees_path, params: { emcee: {name: 'fdsa',email:'fdsainvalid.com', password:'dude', password_confirmation:'dude'}}
    end 
    assert_template 'new'
  end
  
end
