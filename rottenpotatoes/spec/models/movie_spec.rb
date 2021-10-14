require 'rails_helper'

RSpec.describe Movie, type: :model do

    before do
        @movie0 = Movie.create :title=>'TangRen', :rating=>'G', :director=>'Sicheng', :release_date=>'1-Jan-2021'
        @movie1 = Movie.create :title=>'Huanying', :rating=>'R', :director=>'Jia', :release_date=>'3-Jan-2021'
        @movie2 = Movie.create :title=>'Memory', :rating=>'PG', :director=>'Gang', :release_date=>'5-Feb-2020'
        @movie3 = Movie.create :title=>'Memory2', :rating=>'PG', :director=>'Gang', :release_date=>'5-Feb-2021'
        @movie4 = Movie.create :title=>'NoDirector', :rating=>'PG-13', :release_date=>'5-Feb-2000' 
    end

    describe '.find_similar_by_director' do
       it 'return movies with the same director' do
          expect(Movie.find_similar_by_director(@movie2.director)).to eq [@movie2, @movie3] 
       end
        
        it 'never return movies with a different director' do
          expect(Movie.find_similar_by_director(@movie2.director)).to eq [@movie2, @movie3] 
       end
    end
    
    describe '.all_ratings' do
        it 'return all the values of movie ratings' do
            expect(Movie.all_ratings).to eq ["G", "PG", "PG-13", "NC-17", "R"]
        end
    end
    
    describe '.ratings' do
        it 'return all the marked values of movie ratings' do
            expect(Movie.ratings).to eq ["G", "R", "PG", "PG-13"]
        end
    end    

    describe '.movie_ratings' do
        it 'return all the movies with specific ratings' do
            expect(Movie.movies_ratings('PG')).to eq [@movie2, @movie3]
        end
    end
    
    describe '.movies_ratings_sort' do
        it 'return all the movies with specific ratings in the specific order' do
            expect(Movie.movies_ratings_sort('PG', 'release_date')).to eq [@movie2, @movie3]
        end
    end    

end
