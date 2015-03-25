require 'rails_helper'

describe "Logging In" do

	it "logs the user in and goes to titles" do
		User.create(first_name: "Jake", last_name: "test", email: "test@test.com", password: "Test123", password_confirmation: "Test123")

		visit new_user_session_path
		fill_in "Email Address", with: "test@test.com"
		fill_in "Password", with: "Test123"
		click_button "Log In"
		expect(page).to have_content("You have successfully logged in!")
		expect(page).to have_content("Journal")
	end

	it "displays the email address in the event of a failed login" do
		visit new_user_session_path
		fill_in "Email Address", with: "test@test.com"
		fill_in "Password", with: "incorrect"
		click_button "Log In"
		expect(page).to have_content("Please check your email and password.")
		expect(page).to have_field("Email Address", with: "test@test.com")
	end
end


