# frozen_string_literal: true

class Favourite < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
