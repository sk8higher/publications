class Journal < ApplicationRecord
  validates :name, presence: true
  validates :issn, presence: true, uniqueness: true, format: { with: /\A\d{4}-\d{3}[\dX]\z/ }
end
