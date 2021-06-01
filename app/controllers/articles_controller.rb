class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /articles
  def index
    @articles = Article.public_articles

    render json: @articles
  end

  # GET /articles/1
  def show
    if @article.private_article == false || (current_user && current_user.id == @article.user_id)
      render json: @article
    else
      render json: { message: "This article is private."}, status: :unauthorized
    end
  end

  # POST /articles
  def create
    @article = Article.new(title: params[:title], content:params[:content], user_id:current_user.id, private:params[:private])

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.user_id == current_user.id
      if @article.update(title: params[:title], content:params[:content], private:params[:private])
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "You cannot modify other authors' articles."}, status: :unauthorized
    end
  end

  # DELETE /articles/1
  def destroy
    if @article.user_id == current_user.id
      @article.destroy
    else
      render json: { message: "You cannot delete other authors' articles."}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
