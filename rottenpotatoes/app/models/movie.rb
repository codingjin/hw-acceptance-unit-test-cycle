class Movie < ActiveRecord::Base

	def self.find_similar_by_director movie_director
		Movie.where(:director => movie_director) #Movie.where(:director => director) will return all the satisfied records
		#Movie.find will only return single record
	end

    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end

    def self.ratings
       ret = {}
       self.select(:rating).each do |m|
          ret[m.rating] = 1 
       end
        
        return ret.keys
    end
    
    def self.movies_ratings(ratings)
        self.where(:rating => ratings)
    end
    
    def self.movies_ratings_sort(ratings, sort_item)
        self.where(:rating => ratings).order(sort_item)
    end


end
