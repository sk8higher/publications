# frozen_string_literal: true

class Author < ApplicationRecord
  validates :fullname, presence: true
  validates :orcid, presence: true, uniqueness: true, format: { with: /\A\d{4}-\d{4}-\d{4}-\d{3}[0-9X]\z/ }

  has_many :article_authors
  has_many :articles, through: :article_authors

  has_many :chapter_authors
  has_many :chapters, through: :chapter_authors

  has_many :report_authors
  has_many :reports, through: :report_authors

  has_many :presented_reports, class_name: 'Report', foreign_key: 'speaker_id'
end
