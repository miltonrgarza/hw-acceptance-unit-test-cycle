require 'rails_helper'

describe Movie do
    describe '.similar_movies' do
        
        movie1 = Movie.create(title: 'Star Wars', director: 'George Lucas')
        movie2 = Movie.create(title: 'Blade Runner', director: 'Ridley Scott')
        movie3 = Movie.create(title: 'Alien')
        movie4 = Movie.create(title: 'THX-1138', director: 'George Lucas')
        
        context 'director exists' do
            it 'finds movies by same director' do
                results = Movie.similar_movies(movie1.title)
                expect(results) == ([movie1.title, movie4.title])
            end
            
            it 'does not find movies by different directors' do
                results = Movie.similar_movies(movie1.title)
                expect(results).to_not include(movie2.title)
            end
        end
        
        context 'director does not exitst' do
            it 'handles sad path' do
                results = Movie.similar_movies(movie4.title)
                expect(results) == (nil)
            end
        end
        
    end
end