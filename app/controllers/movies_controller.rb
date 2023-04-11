class MoviesController < ApplicationController

  def index
    @movies = ["The Dark Knight", "Clerks", "Braveheart", "Indiana Jones and the Raiders of the Lost Ark", "Star Wars: A New Hope" ]
  end
end
