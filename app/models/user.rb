# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  has_many :favourites, dependent: :destroy

  has_many :favourite_movies, through: :favourites, source: :movie

  validates :name, presence: true

  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensiteve: false }

  validates :username, presence: true,
                       format: { with: /\A[A-Z0-9]+\z/i },
                       uniqueness: { case_sensiteve: false }

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { where(admin: false).by_name }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
