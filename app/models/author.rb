class Author < ApplicationRecord
  validates :fullname, presence: true
  validates :orcid, presence: true, format: { with: /\A\d{4}-\d{4}-\d{4}-\d{3}[0-9X]\z/ }
end
