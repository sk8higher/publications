# frozen_string_literal: true

class ArticleAuthor < ApplicationRecord
  belongs_to :article
  belongs_to :author
end
