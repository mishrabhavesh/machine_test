class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update,:like]
  before_action :require_login ,only: [:create,:new,:edit]
  before_action :require_author , only: [:edit,:update,:destroy]
  def index
    @articles = Article.all
  end

  def comment
    Article.comment(params[:search],current_user.current_article,current_user.id)
    @article = Article.find(current_user.current_article)
    redirect_to article_path(@article)
  end

  def category_search
    @articles = Article.search(params[:category_id])
  end

  def my_liked
    liked_list = LickedSotck.where(user_id: current_user.id)
    @articles = liked_list.article
  end
  
  def show
    if logged_in?
    current_user.current_article = @article.id
    current_user.save
    @comments = @article.comments
    end
  end

  def new
    @article = Article.new
  end
  

  def edit    
  end

  def like
   @article =  Article.find(params[:id])
   if(LickedSotck.where(article_id: @article.id).any? && LickedSotck.where(user_id: current_user.id).any?)
   else
    @article.increment(:like)
    @article.save
    LickedSotck.create!(user_id: current_user.id, article_id: @article.id)
   end
   redirect_to articles_path

  end


  def dislike
    @article =  Article.find(params[:id])

    if(DislikedStock.where(article_id: @article.id ).any? && DislikedStock.where(user_id: current_user.id).any?)
    
    else
      @article.increment(:dislike)
    @article.save
    DislikedStock.create!(user_id: current_user.id, article_id: @article.id)
    
    end
    redirect_to articles_path

  end

 

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.' 
      else
        render :new
      end
  end

  def update
      if @article.update(article_params)
       redirect_to @article, notice: 'Article was successfully updated.' 
      else
        format.html { render :edit }
      end
  end



  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :image,:category_id,:user_id)
    end

    def require_author
      if logged_in? && (current_user.id != @article.user.id)
        redirect_to articles_path, notice: "You can edit your own article"
      end
    end
end
