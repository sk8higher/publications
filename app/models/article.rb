class Article < ApplicationRecord
  belongs_to :journal

  has_many :article_authors
  has_many :authors, through: :article_authors

  validates :orig_name, :eng_name, :publish_date, :doi, presence: true
  validates :doi, presence: true, uniqueness: true, format: { with: /\A10\.\d{4,9}\/[-._;()\/:A-Z0-9]+\z/i }
end
