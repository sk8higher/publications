# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
    @authors = Author.all
  end

  def create
    @authors = Author.all
    @report = Report.new(report_params)

    if @report.save
      redirect_to report_path(@report)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @report = Report.find(params[:id])
    @author = Author.find(@report.speaker_id)
  end

  def edit
    @report = Report.find(params[:id])
    @authors = Author.all
  end

  def update
    @report = Report.find(params[:id])
    @authors = Author.all

    if @report.update(report_params)
      redirect_to @report
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find(params[:id])

    @report.destroy

    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:orig_name, :eng_name, :publish_date, :conference_name, :conference_location,
                                   :speaker_id, author_ids: [])
  end
end
