require 'rails_helper'

describe "Listing Journal Entries" do

	it "requires login" do
		visit "/titles"
		expect(page).to have_content("You must be logged in")
	end

end
