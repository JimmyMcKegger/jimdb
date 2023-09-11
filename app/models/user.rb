# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # Callbacks
  before_save :format_username
  before_save :set_slug

  # ActiveRecord relationships
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :movie

  # Validations
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensiteve: false }
  validates :username, presence: true,
                       format: { with: /\A[A-Z0-9]+\z/i },
                       uniqueness: { case_sensiteve: false }

  # Scopes
  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { where(admin: false).by_name }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end

  def format_username
    self.username = username.downcase
  end

  def set_slug
    self.slug = username.parameterize
  end

  def to_param
    slug
  end
end
