# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 4, message: 'Comments should be longer...' }

  validates :stars,
            numericality: { only_integer: true, greater_than: 0, less_than: 6, message: 'must be between 1 and 5' }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end

  STAR_OPTIONS = [
    1,
    2,
    3,
    4,
    5
  ].freeze
end
