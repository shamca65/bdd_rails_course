require "rails_helper"

Rspec.feature "Deleting an Article" do
  before do
    @article = Article.create(title: "Title 1", body: "Body 1")
  end
  
  scenario "A user deletes an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article" 
    
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)

  end
  
end