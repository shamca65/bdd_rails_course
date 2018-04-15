class ArticlesController < ApplicationController
  #ruby filter  - the private method set_article will be run first for the 
  # actions listed
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only:[:show, :edit, :update, :destroy]
  
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
  
  def show
   
  end
  
  def edit
   
  end
 
  def update
    
    @article.update_attributes article_params
    if @article.save 
      flash[:notice] = "Article has been updated"
      redirect_to(@article)
    else
      flash[:notice] = "Article has not been updated"
      render 'edit'
    end 
  end 
  
  def destroy
    
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end
  
  protected
  
  def resource_not_found
    message = "The article you are looking for does not exist"
    flash[:alert] = message
    redirect_to root_path
  end

  private 
  
  def set_article
   @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
