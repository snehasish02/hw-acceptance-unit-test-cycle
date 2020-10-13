require 'rails_helper'
describe MoviesController do
  describe 'Search movies by the same director' do
    context "specified movie has a director" do
           it 'should select samedirector template for rendering' do
              fake_results = [double('movie1'), double('movie2')]
              allow(Movie).to receive(:same_director).with('Star Wars').and_return(fake_results)
              post :samedirector, { title: 'Star Wars' } 
              expect(response).to render_template('samedirector')
           end

           it 'should call Movie.same_director' do
              fake_results = [double('movie1'), double('movie2')]
              expect(Movie).to receive(:same_director).with('Star Wars').and_return(fake_results)
              post :samedirector, { title: 'Star Wars' }
          end
           it 'should make the search results of the model method available to the template' do
              fake_results = [double('movie1'), double('movie2')]
              allow(Movie).to receive(:same_director).with('Star Wars').and_return(fake_results)
              post :samedirector, { title: 'Star Wars' } 
              expect(assigns(:movies)).to eq(@fake_results)
          end

    end
    context "specified movie has no director" do
           it 'redirects to the home page' do
               fake_results = nil
               expect(Movie).to receive(:same_director).with('Aliens').and_return(fake_results)
               post :samedirector, { title: 'Aliens' }
               expect(response).to redirect_to(movies_path)
           end
           it 'flashes a error message' do
               fake_results = nil
               expect(Movie).to receive(:same_director).with('Aliens').and_return(fake_results)
               post :samedirector, { title: 'Aliens' }
               expect(flash[:notice]).to match(/(.*) has no director info*/)
           end
    end
  end
end 
