# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true

  validates :comment, length: { minimum: 4, message: "must be longer" }

  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than: 6,  message: "must be between 1 and 5"}
end
