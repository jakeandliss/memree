require 'rails_helper'

describe "Editing Profile" do
	let(:user) { create(:user) }
  	before { sign_in user, password: 'test123' }

  	def visit_edit_profile
  		visit user_path(user)
		expect(page).to have_content("Here's your profile page")
		click_link "Edit Profile"
  	end

  	def visit_edit_password
  		visit user_path(user)
		expect(page).to have_content("Here's your profile page")
		click_link "Edit Profile"
		click_link "Update Password"
	end

	it "updates profile first name" do
		visit_edit_profile

		fill_in "First Name", with: "NewTest"
		click_button "Update Profile"

		expect(page).to have_field('First Name', with: 'NewTest')

	end

	it "updates profile last name" do
		visit_edit_profile
		
		fill_in "Last Name", with: "NewTest"
		click_button "Update Profile"

		expect(page).to have_field('Last Name', with: 'NewTest')

	end

	it "updates profile last name" do
		visit_edit_profile
		
		fill_in "Email", with: "NewTest@email.com"
		click_button "Update Profile"

		expect(page).to have_field('Email', with: 'NewTest@email.com')

	end


end