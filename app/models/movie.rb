# frozen_string_literal: true

class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17].freeze

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy

  has_many :critics, through: :reviews, source: :user

  has_many :favourites, dependent: :destroy

  has_many :fans, through: :favourites, source: :user

  has_many :characterizations, dependent: :destroy

  has_many :genres, through: :characterizations

  validates :title, :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :rating, inclusion: { in: RATINGS }

  # def self.released
  #   where('released_on < ?', Time.now).order(released_on: :desc)
  # end

  scope :released, -> { where('released_on < ?', Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where('released_on > ?', Time.now).order(released_on: :desc) }
  scope :recent, ->(max=5) { released.limit(max) }
  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc) }
  scope :flops, -> { released.where("total_gross < 225000000").order(total_gross: :asc) }

  def flop?
    # exclude cult favorites from flops
    return if reviews.count > 50 && average_stars >= 4

    (total_gross.blank? || total_gross < 225_000_000)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end
end
