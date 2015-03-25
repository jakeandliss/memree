require 'rails_helper'

describe "forgotten passwords" do 
	let(:user) { create(:user) }

	it "sends a user an email" do
		visit login_path
		click_link "Forgot Password"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change{ ActionMailer::Base.deliveries.size }.by(1)
	end

	it "resets a password when following the email link" do
		visit login_path
		click_link "Forgot Password"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change{ ActionMailer::Base.deliveries.size }.by(1)
		open_email(user.email)
		current_email.click_link "http://"
		expect(page).to have_content("Change Your Password")

		fill_in "Password", with: "newpassword1"
		fill_in "Password Confirmation", with: "newpassword1"

		click_button "Change Password"
		expect(page).to have_content("has been updated")
		expect(page.current_path).to eq(titles_path)

		click_link "Log Out"
		expect(page).to have_content("You have been logged out.")

		visit login_path
		fill_in "Email", with: user.email
		fill_in "Password", with: "newpassword1"
		click_button "Log In"
		expect(page).to have_content("You have successfully logged in")
	end


end
