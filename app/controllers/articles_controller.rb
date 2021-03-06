class ArticlesController < ApplicationController
  #ruby filter  - the private method set_article will be run first for the 
  # actions listed
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only:[:show, :edit, :update, :destroy]
  
  def index
    @articles=Article.all
  end
  
  def new
    #need a view for new (template)
    @article = Article.new
    @comments = @article.comments
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created" #display the flash message once
      render :new
    end
  end
  
  def show
    # build adds a new comment to the comment collection
    @comment = @article.comments.build
    @comments = @article.comments
  end
  
  def edit
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own articles"
      redirect_to root_path
    end
  end
 
  def update
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own articles"
    redirect_to root_path
    else
      @article.update_attributes article_params
      if @article.save 
        flash[:notice] = "Article has been updated"
        redirect_to(@article)
      else
        flash[:notice] = "Article has not been updated"
        render 'edit'
      end
    end
  end 
  
  def destroy
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own articles"
      redirect_to root_path
    else
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
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
