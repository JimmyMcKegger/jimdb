# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  has_many :favourites, dependent: :destroy

  validates :name, presence: true

  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensiteve: false }

  validates :username, presence: true,
                       format: { with: /\A[A-Z0-9]+\z/i },
                       uniqueness: { case_sensiteve: false }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
