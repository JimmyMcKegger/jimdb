# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensiteve: false }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
