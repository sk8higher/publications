class ChapterAuthor < ApplicationRecord
  belongs_to :chapter
  belongs_to :author
end
