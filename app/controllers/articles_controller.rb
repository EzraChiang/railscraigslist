class ArticlesController < ApplicationController
  def new
    @category = Category.find(params[:category_id])
    @article = Article.new
  end

  def secret
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find_by(secret: params[:secret])
    @category = Category.find(params[:category_id])
    redirect_to category_path(@category) if @article == nil
  end

  def update
    @article = Article.find(params[:id])
    @category = Category.find(params[:category_id])
    if @article.update_attributes(article_params)
      redirect_to "/categories/#{@category.id}/articles/#{@article.id}"
    else
      @errors = @article.errors.full_messages
      render :edit, status: 422
    end
  end

  def show
    @article = Article.find(params[:id])
    @category = @article.category
  end

  def create
    @category = Category.find(params[:category_id])
    @article = @category.articles.build(article_params)
    if @article.save
      @article.secret = @article.randomizer
      @article.save
      redirect_to "/categories/#{@category.id}/articles/#{@article.id}/secret"
    else
      @errors = @article.errors.full_messages
      render :new, status: 422
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @category = @article.category
    if @article.destroy
      redirect_to category_path(@category, @article)
    else
      render :show, status: 422
    end
  end


  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
