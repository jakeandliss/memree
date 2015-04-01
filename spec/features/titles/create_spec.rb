require 'rails_helper'

describe "Creating Journal Titles" do
	let(:user) { create(:user) }

  def create_title(options={})
    options[:title] ||= "My Journal Title"
    options[:entry] ||= "This is my Journal Entry."

    visit "/titles"

    fill_in "Entry Title", with: options[:title]
    fill_in "Your entry goes here...", with: options[:entry]
    click_button "Save Entry"
  end

  before do
  	sign_in user, password: "Test123"
  end
  
  it "redirects to the Journal Entry index page on success" do
    create_title
    expect(page).to have_content("My Journal Title")
  end

  it "displays an error when the Journal has no title" do
    expect(Title.count).to eq(0)

    create_title title: ""

    expect(page).to have_content("There was a problem adding your entry.")
    expect(Title.count).to eq(0)

    visit "/titles"
    expect(page).to_not have_content("This is my journal entry")
  end

end