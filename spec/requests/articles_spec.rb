require "rails_helper"

RSpec.describe "Articles", type: :request do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "Title One", body: "Body one", user: @john)
  end
  
  describe 'GET /articles/:id/edit' do
    
      context 'with a non-signed in user ' do
        before {get "/articles/#{@article.id}/edit"}
        
        it 'redirects to the signin page' do
          expect(response.status).to eq 302
          flash_message = 'You need to sign in or sign up before continuing.'
          expect(flash[:alert]).to eq flash_message
        end
        
      end
      
      context 'with a non-signed in user who is a non-owner' do
        before do
          login_as(@fred)
          get "/articles/#{@article.id}/edit" 
        end
        
        it 'redirects to the home page' do
          expect(response.status).to eq 302
          flash_message = 'You can only edit your own articles'
          expect(flash[:danger]).to eq flash_message
        end
      end
      
      context 'with a signed in user who is an owner successful edit' do
        before do
          login_as(@john)
          get "/articles/#{@article.id}/edit" 
        end
        
        it 'successfully edits the article' do
          expect(response.status).to eq 200
        end
      end   
  end
  
  
  describe 'GET /articles/:id' do
    context 'with existing article' do
      before {get "/articles/#{@article.id}"}
      
      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end
    
    context "with non-existing article" do
      before { get "/articles/xxxx" }
      
      it "handles non-existing articles" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for does not exist"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end