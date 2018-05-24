require "rails_helper"

RSpec.describe "Comments", type: :request do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "Title One", body: "Body one", user: @john)
  end
  
  describe "POST /articles/:id/comments" do
    
    context "with a non-signed in user" do
      
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article"}}
      end
    
      it 'redirects user to the sign-in page' do
       flash_message = "Please sign in or sign up first"
       expect(response).to redirect_to(new_user_session_path)
       expect(response.status).to eq 302
       expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with a signed in user" do
      
      before do
          login_as(@fred)
           post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article"}}
        end
    
      it 'creates the comment sucessfully' do
       flash_message = "Comment has been created"
       expect(response).to redirect_to(article_path(@article.id))
       expect(response.status).to eq 302
       expect(flash[:alert]).to eq flash_message
      end
    end
  end
# RSpec
end

     