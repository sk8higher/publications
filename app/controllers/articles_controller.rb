class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @authors = Author.all
    @journals = Journal.all
  end

  def create
    @authors = Author.all
    @journals = Journal.all
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
    @journal = Journal.find(@article.journal_id)
  end

  private

  def article_params
    params.require(:article).permit(:orig_name, :eng_name, :publish_date, :doi, :journal_id, :author_ids => [])
  end
end
