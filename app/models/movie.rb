# Movie model
class Movie < ActiveRecord::Base
  def self.all_ratings_names
    Movie.select(:rating).distinct.map(&:rating)
  end

  def self.retrieve_checked_ratings(checked_ratings)
    Movie.where(rating: checked_ratings)
  end
end
