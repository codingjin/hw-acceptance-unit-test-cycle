class Movie < ActiveRecord::Base

	def self.find_similar_by_director movie_director
		Movie.where(:director => movie_director) #Movie.where(:director => director) will return all the satisfied records
		#Movie.find will only return single record
	end

end
