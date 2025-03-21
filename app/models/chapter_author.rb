# frozen_string_literal: true

class ChapterAuthor < ApplicationRecord
  belongs_to :chapter
  belongs_to :author
end
