# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :author_reports, dependent: :destroy
  has_many :authors, through: :author_reports

  belongs_to :speaker, class_name: 'Author', foreign_key: 'speaker_id'

  validates :orig_name, :eng_name, :publish_date, :conference_name, :conference_location, :authors, presence: true
end
