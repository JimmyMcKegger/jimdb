# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "#{@movie.title} created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "#{@movie.title} updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    logger.info "Processing the request to delete #{@movie.title}"
    @movie.destroy

    redirect_to movies_url, status: :see_other, alert: "#{@movie.title} deleted!"
  end

  private

  def movie_params
    params.require(:movie)
          .permit(:title, :rating, :total_gross, :description, :released_on, :director, :duration, :image_file_name)
  end
end
