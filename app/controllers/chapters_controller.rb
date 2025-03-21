# frozen_string_literal: true

class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
  end

  def new
    @chapter = Chapter.new
    @authors = Author.all
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @authors = Author.all

    if @chapter.save
      redirect_to chapter_path(@chapter)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @chapter = Chapter.find(params[:id])
  end

  def edit
    @chapter = Chapter.find(params[:id])
    @authors = Author.all
  end

  def update
    @chapter = Chapter.find(params[:id])

    if @chapter.update(chapter_params)
      redirect_to @chapter
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])

    @chapter.destroy

    redirect_to chapters_path
  end

  private

  def chapter_params
    params.require(:chapter).permit(:orig_name, :eng_name, :publish_date, :publisher, :isbn, :pages, author_ids: [])
  end
end
