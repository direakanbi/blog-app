require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before :each do
      get '/users'
    end

    it 'should respond to the correct http status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct resource template' do
      expect(response).to render_template(:index)
    end

    it 'should respond to the correct body placeholder text' do
      expect(response.body).to include('Here is the users home page')
    end
  end

  describe 'GET /show' do
    before :each do
      get '/users/1'
    end

    it 'should respond to the correct http status' do
      expect(response.status).to eq(200)
    end

    it 'should render the correct resource template' do
      expect(response).to render_template(:show)
    end

    it 'should respond to the correct body placeholder text' do
      expect(response.body).to include('Here is a list of user')
    end
  end
end
