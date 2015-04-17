require 'rails_helper'

describe "forgotten passwords" do 
	let(:user) { create(:user) }

	it "sends a user an email" do
		visit new_user_session_path
		click_link "Forgot your password?"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change{ ActionMailer::Base.deliveries.size }.by(1)
	end

	it "resets a password when following the email link" do
		visit new_user_session_path
		click_link "Forgot your password?"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change{ ActionMailer::Base.deliveries.size }.by(1)
		open_email(user.email)
		current_email.click_link "Change my password"
		expect(page).to have_content("Change your password")

		fill_in "New Password", with: "newpassword1"
		fill_in "Confirm New Password", with: "newpassword1"

		click_button "Change My Password"
		expect(page).to have_content("changed successfully")
		expect(page.current_path).to eq(user_root_path)

		click_link "Log Out"
#		expect(page).to have_content("You have been logged out.")

		visit new_user_session_path
		fill_in "Email", with: user.email
		fill_in "Password", with: "newpassword1"
		click_button "Log In"
		expect(page).to have_content("You have successfully logged in")
	end


end
