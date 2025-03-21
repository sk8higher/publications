class Author < ApplicationRecord
  validates :fullname, presence: true
  validates :orcid, presence: true, format: { with: /\A\d{4}-\d{4}-\d{4}-\d{3}[0-9X]\z/ }

  has_many :article_authors
  has_many :articles, through: :article_authors

  has_many :chapter_authors
  has_many :chapters, through: :chapter_authors
end
