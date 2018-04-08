require "rails_helper"

RSpec.feature "Create a New Article" do
  scenario "A user creates a new article" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: "Test Article"
    fill_in "Body",  with: "Lorem Ipsum"
    click_button "Create Article"
    
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(Articles_Path)
  end
end
