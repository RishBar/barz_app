require "application_system_test_case"

class EmceesTest < ApplicationSystemTestCase
  setup do
    @emcee = emcees(:one)
  end

  test "visiting the index" do
    visit emcees_url
    assert_selector "h1", text: "Emcees"
  end

  test "creating a Emcee" do
    visit emcees_url
    click_on "New Emcee"

    fill_in "Email", with: @emcee.email
    fill_in "Name", with: @emcee.name
    fill_in "Password", with: @emcee.password
    click_on "Create Emcee"

    assert_text "Emcee was successfully created"
    click_on "Back"
  end

  test "updating a Emcee" do
    visit emcees_url
    click_on "Edit", match: :first

    fill_in "Email", with: @emcee.email
    fill_in "Name", with: @emcee.name
    fill_in "Password", with: @emcee.password
    click_on "Update Emcee"

    assert_text "Emcee was successfully updated"
    click_on "Back"
  end

  test "destroying a Emcee" do
    visit emcees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Emcee was successfully destroyed"
  end
end
