class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.FindMoviesWithSameDirector(id)
    movie = self.find(id)
    movies = self.where(:director => "#{movie.director}")
    return movies
  end
end
