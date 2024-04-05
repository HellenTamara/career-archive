class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles
    @articles_list = current_user.articles
    if params[:start_date].present?
      @articles_list = Article.where(date: params[:start_date]..params[:end_date], user_id: current_user.id)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_filtered)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params_filtered)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  private

  def params_filtered
    params.require(:article).permit(:title, :content, :photos, :date, :start_date, :end_date )
  end
end
