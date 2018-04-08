class ArticlesController < ApplicationController
  def index
    @articles=Article.all
  end
  
  def new
    #need a view for new (template)
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created" #display the flash message once
      render :new
    end
  end
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
