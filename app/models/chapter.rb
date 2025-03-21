# frozen_string_literal: true

class Chapter < ApplicationRecord
  has_many :chapter_authors, dependent: :destroy
  has_many :authors, through: :chapter_authors

  validates :orig_name, :eng_name, :publish_date, :isbn, :publisher, :pages, :authors, presence: true
  validate :valid_isbn_format

  private

  def valid_isbn_format
    return if isbn.blank?

    cleaned_isbn = isbn.gsub(/[-\s]/, '')

    if cleaned_isbn.length == 10
      errors.add(:isbn, 'is not a valid ISBN-10') unless valid_isbn10?(cleaned_isbn)
    elsif cleaned_isbn.length == 13
      errors.add(:isbn, 'is not a valid ISBN-13') unless valid_isbn13?(cleaned_isbn)
    else
      errors.add(:isbn, 'must be either 10 or 13 characters long')
    end
  end

  def valid_isbn10?(isbn)
    sum = 0
    isbn.chars.each_with_index do |char, index|
      sum += if index == 9 && char.upcase == 'X'
               10
             else
               char.to_i * (10 - index)
             end
    end
    (sum % 11).zero?
  end

  def valid_isbn13?(isbn)
    sum = 0
    isbn.chars.each_with_index do |char, index|
      digit = char.to_i
      sum += if index.even?
               digit
             else
               digit * 3
             end
    end
    (sum % 10).zero?
  end
end
