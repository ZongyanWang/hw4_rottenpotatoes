require 'spec_helper'

describe MoviesController do
  before :each do
    @fake_results = [mock('movie'), mock('movie2')]
    @fake_movie = FactoryGirl.build(:movie, :id => 100, :title => "Factory Girl", :director => 'Quan') 
    @fake_movie1 = FactoryGirl.build(:movie, :id => 100, :title => "Factory Girl") 
  end
  
  describe 'Adding director information to an existing movie' do
    it 'should call the model method that update the attributes of the movie' do

      Movie.should_receive(:find).with(@fake_movie.id.to_s).
        and_return(@fake_movie)

      @fake_movie.should_receive(:update_attributes!).with("director" => @fake_movie.director).
        and_return(true)
      put :update, { :id => @fake_movie.id.to_s, :movie => {:director => @fake_movie.director}}
      flash[:notice].should have_content("#{@fake_movie.title} was successfully updated.")
    end
    it 'should select the Show template for rendering' do
      Movie.should_receive(:find).with(@fake_movie.id.to_s).
        and_return(@fake_movie)
      get :show, {:id => @fake_movie.id.to_s }
      response.should render_template("show")
    end
    
  end
  
  describe 'Searching by director' do
    
    it 'should validate director and flash error if the director is not given' do
      Movie.stub(:find).and_return(@fake_movie1)
      get :same_director, { :id => @fake_movie1.id.to_s}   
      response.should redirect_to("/movies")
      flash[:notice].should have_content("'#{@fake_movie1.title}' has no director info")
    end
    
    it 'should call the model method that performs director search, if the director is given' do  
      Movie.stub(:find).and_return(@fake_movie)
      Movie.should_receive(:FindMoviesWithSameDirector).with(@fake_movie.id.to_s).
        and_return(@fake_results)
      get :same_director, { :id => @fake_movie.id.to_s}    
    end
     
    describe 'after valid search' do
      before :each do  
        Movie.stub(:find).and_return(@fake_movie)
        Movie.stub(:FindMoviesWithSameDirector).and_return(@fake_results)
        get :same_director, { :id => @fake_movie.id.to_s}
      end
      it 'should select the Search Results template for rendering' do
        response.should render_template("same_director")
      end
      it 'should make the director search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
end
