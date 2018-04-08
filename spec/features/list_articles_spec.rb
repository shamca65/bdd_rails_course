require "rails_helper"

RSpec.feature "Listing Articles" do

  # create 2 articles to display

  before do
    @article1 = Article.create(title: "This is the first", body: "This is the body 1")
    @article2 = Article.create(title: "This is the second", body: "This is the body 2")
  end
  
  scenario "A user lists all articles" do
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "A user has no articles" do
    Article.delete_all
    
    visit "/"
    
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
    
    within("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
    
  end

end