require 'rails_helper'

describe "Signing Up" do
	 
	 it "allow a user to sign up for the site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Get Started")
		click_link "Get Started"

		fill_in "First Name", with: "Test"
		fill_in "Last Name", with: "Test"
		fill_in "Email", with: "Test@Test.com"
		fill_in "Password", with: "Test123"
		fill_in "Password confirmation", with: "Test123"
		click_button "Register"

		expect(User.count).to eq(1)

	end
end
