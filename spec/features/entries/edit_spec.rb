require 'rails_helper'

describe "Editing entries" do
  let!(:title) { user.titles.create(title: "I love My Journal") }
  let!(:entry) { title.entries.create(entry: "My New Entry Here") }  
  let(:user) { create(:user) }
  before { sign_in user, password: 'test123' }


  it "is successful with valid entry" do
    visit title_entries_path(title)
    within("#entry_#{entry.id}") do
      click_link "Edit"
    end
    fill_in "Entry", with: "Another New Entry Here"
    click_button "Save"
    expect(page).to have_content("Another New Entry Here")
    entry.reload
    expect(entry.entry).to eq("Another New Entry Here")
  end

  it "is unsuccessful with no entry" do
    visit title_entries_path(title)
    within("#entry_#{entry.id}") do
      click_link "Edit"
    end
    fill_in "Entry", with: ""
    click_button "Save"
    expect(page).to_not have_content("Entry added successfully.")
    expect(page).to have_content("Your entry could not be saved")
    entry.reload
    expect(entry.entry).to eq("My New Entry Here")
  end

end