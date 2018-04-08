class ArticlesController < ApplicationController
  def index
  end
  
  def new
    #need a view for new (template)
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.save
    flash[:sucess] = "Article has been created"
    redirect_to articles_path
  end
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
end