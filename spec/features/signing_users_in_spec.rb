require "rails_helper"

RSpec.feature "Users signin" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
  end
  
  scenario "with valid credentials" do
    visit "/"
    clink_link "Sign in"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
  
    click_button "Login"
    
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
    
  end
end