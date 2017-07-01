# Movies controller
class MoviesController < ApplicationController
  # before_action :set_session, only: [:index]

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if (!params[:ratings] && session[:checked_rating]) || (!params[:col] && session[:order_column])
      new_params = {}
      new_rating_params = Hash[session[:checked_rating].collect { |v| [v, '1'] }] if session[:checked_rating]
      new_params[:ratings] = params.fetch(:ratings, new_rating_params)
      new_params[:col] = params.fetch(:col, session[:order_column])
      req_params = new_params.select { |k,v| v }
      flash.keep(:notice)
      redirect_to movies_path(req_params) unless req_params.empty?
    end

    ## filtering
    @all_ratings = Movie.all_ratings_names
    ratings_to_filter = params[:ratings].blank? ? @all_ratings : params[:ratings].keys
    session[:checked_rating] = ratings_to_filter

    ## ordering
    session[:order_column] = params[:col] unless params[:col].blank?

    #### to send to the view
    @movies = Movie.where(rating: session[:checked_rating])
    @movies = @movies.order(session[:order_column].to_sym => :asc) if session[:order_column]
    @checked_ratings = session[:checked_rating]
    @order_column = session[:order_column]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  # def set_session
  # end
end
