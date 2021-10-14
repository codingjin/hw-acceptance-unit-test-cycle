require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe MoviesController, type: :controller do
    before do
        @movie0 = Movie.create :title=>'TangRen', :rating=>'G', :director=>'Sicheng', :release_date=>'1-Jan-2021'
        @movie1 = Movie.create :title=>'Huanying', :rating=>'R', :director=>'Jia', :release_date=>'3-Jan-2021'
        @movie2 = Movie.create :title=>'Memory', :rating=>'PG', :director=>'Gang', :release_date=>'5-Feb-2020'
        @movie3 = Movie.create :title=>'Memory2', :rating=>'PG', :director=>'Gang', :release_date=>'5-Feb-2021'
        @movie4 = Movie.create :title=>'NoDirector', :rating=>'PG-13', :release_date=>'5-Feb-2000'
    end
    
    describe 'Put #similar' do
        context 'has a director' do
            it 'destory the specific movie' do
                put :similar, :id=>@movie2.id
                expect(assigns[:movies]).to eq [@movie2, @movie3]
                expect(response).to render_template('similar') 
            end
        end
        
        context 'has no director' do
            it 'redirect to homepage' do
                put :similar, :id=>@movie4.id
                expect(response).to redirect_to movies_path
            end
        end
    end
    
    describe 'Get #index' do
        it 'returns all movies' do
           get :index
           expect(assigns(:movies)).to eq [@movie0, @movie1, @movie2, @movie3, @movie4]
        end
        
        it 'display homepage' do
           get :index
           expect(response).to render_template('index')
        end
    end
    
    describe 'Get #show' do
       it 'returns details page of the specific movie' do
          get :show, :id=>@movie2.id
          expect(response).to render_template("show")
          expect(assigns[:movie]).to eq @movie2
       end
    end
    
    describe 'Get #new' do
       it 'returns the new page' do
           get :new
           expect(response).to render_template 'new'
        end
    end
    
    describe 'Get #edit' do
        it 'it display the edit page of a specific movie' do 
            get :edit, :id=>@movie2.id
            expect(response).to render_template("edit")
            expect(assigns[:movie]).to eq @movie2
        end
    end
    
    describe 'Put #create' do
        it 'go through create logic' do 
            put :create, :movie=> {title: 'Createmovie'}
            expect(assigns[:movie].title).to eq 'Createmovie'
        end
    end
    
    context 'Put #update' do
        it 'update the attributes of a specific movie and also redirect to that page' do 
            put :update, :id=>@movie0.id, :movie=> {title: 'u01', director: 'd01'}
            expect(assigns[:movie].title).to eq 'u01'
            expect(assigns[:movie].director).to eq 'd01'
            expect(response).to redirect_to movie_path(@movie0)
        end
    end
    
    describe 'Get #similar' do
        context 'has a director' do
            it 'destory the specific movie' do
                get :similar, :id=>@movie2.id
                expect(assigns[:movies]).to eq [@movie2, @movie3]
                expect(response).to render_template('similar') 
            end
        end
        
        context 'has no director' do
            it 'redirect to homepage' do
               get :similar, :id=>@movie4.id
               expect(response).to redirect_to movies_path
            end
        end
    end
    
    describe 'Put #destory' do
        it 'redirect to movies page' do 
            put :destroy, :id=>@movie0.id
            expect(response).to redirect_to(movies_path)
        end
    end

end
