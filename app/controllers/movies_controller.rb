class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :set_var_for_new, only: [:index]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.valid?
      flash[:errors] = "Movie Created Succesfully"
      redirect_to movies_path
    else
      flash[:errors] = @movie.errors.full_messages
      redirect_to new_movie_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:errors] = "Movie Updated Successfully"
      redirect_to movie_path(@movie)
    else
      flash[:errors] = @movie.errors.full_messages
      redirect_to edit_movie_path
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  def delete_file
    file = ActiveStorage::Attachment.find(params[:id])
    file.purge
    redirect_back(fallback_location: movies_path)
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:movie_name, :release_date, :description, :poster, images: [])
  end

  def set_var_for_new
    @new_btn = true
  end
end
