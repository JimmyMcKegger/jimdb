# frozen_string_literal: true

module FavouritesHelper

  def fave_or_unfave_button(movie, favourite)
    if favourite.present?
      button_to "♡ Unfave", movie_favourite_path(movie, favourite), method: :delete
    else
      button_to "♥️ Fave", movie_favourites_path(movie)
    end
  end
end
