class Report < ApplicationRecord
  has_many :author_reports
  has_many :authors, through: :author_reports

  validates :orig_name, :eng_name, :publish_date, :conference_name, :conference_location, presence: true
end
