require 'spec_helper'

describe Movie do
  before :each do
    @fake_results = [mock('movie'), mock('movie2')]
    @fake_movie = FactoryGirl.build(:movie, :id => 100, :title => "Factory Girl", :director => 'Quan') 
  end
  
   describe 'searching same director' do
    it 'should call Movie with director' do
      Movie.should_receive(:find).with(@fake_movie.id.to_s).
        and_return(@fake_movie)
      Movie.should_receive(:where).with(:director => @fake_movie.director).
        and_return(@fake_results)
      Movie.FindMoviesWithSameDirector(@fake_movie.id.to_s)
      
    end
  end
  
end