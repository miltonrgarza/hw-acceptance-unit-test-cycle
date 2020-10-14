require 'rails_helper'
include MoviesHelper

describe MoviesController do
    describe 'find movies with same director' do
        
        it 'should call Movie.similar_movies' do
            expect(Movie).to receive(:similar_movies).with('Star Wars')
            get :similar, {title: 'Star Wars'}
        end
        
        it 'should assign similar movies if director exists' do
            movies = ['THX-1138', 'Alien']
            Movie.stub(:similar_movies).with('THX-1138').and_return(movies)
            get :similar, {title: 'THX-1138'}
            expect(assigns(:similar_movies)).to eql(movies)
        end
        
        it 'should redirect to home page if director is unknown' do
            Movie.stub(:similar_movies).with('No name').and_return(nil)
            get :similar, {title: 'No name'}
            expect(response).to redirect_to(root_url)
        end
        
    end
    
    describe '.all_ratings' do
        it 'returns all ratings' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
    
    describe 'GET index' do
        
        it 'should render the index templete' do
            get :index
            expect(response).to render_template('index')
        end
        
        it 'should assign instance variable for title header' do
            get :index, {sort: 'title'}
            expect(assigns(:title_header)) == ('hilite')
        end
        
        it 'should assign instance variable for release_date header' do
            get :index, {sort: 'release_date'}
            expect(assigns(:date_header)) == ('hilite')
        end
    end
    
    describe 'create movie' do
        it 'should create a movie' do
            post :create, :movie => {:title => 'fake'}
            assigns(:movie).title.should == 'fake'
        end
    end        
    
    describe 'DELETE #destroy' do
        let!(:movie1) { FactoryGirl.create(:movie) }

        it 'destroys a movie' do
            expect { delete :destroy, id: movie1.id}.to change(Movie, :count).by(-1)
        end

        it 'redirects to movies#index after destroy' do
            delete :destroy, id: movie1.id
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'oddness' do
        
        it 'should be even' do
            oddness(Movie.count).should == "even"
        end
        
        it 'should not be odd' do
            oddness(Movie.count).should_not == "odd"
        end
    end
end