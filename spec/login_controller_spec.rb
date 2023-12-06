# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user_info) do
    {
      'provider' => 'google_oauth2',
      'uid'      => '123456',
      'info'     => {
        'first_name' => 'John',
        'last_name'  => 'Doe',
        'email'      => 'john.doe@example.com'
      }
    }
  end

  describe 'POST #google_oauth2' do
    before do
      request.env['omniauth.auth'] = user_info
      allow(User).to receive(:find_by).and_return(nil)
      allow(controller).to receive(:create_google_user).with(user_info).and_call_original
    end

    it 'creates a new user session for Google user' do
      post :google_oauth2
      expect(User).to have_received(:find_by)
      expect(controller).to have_received(:create_google_user).with(user_info)
      expect(session[:current_user_id]).not_to be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST #github' do
    before do
      modified_user_info = user_info.merge('provider' => 'github')
      request.env['omniauth.auth'] = modified_user_info
      allow(User).to receive(:find_by).and_return(nil)
      allow(controller).to receive(:create_github_user).with(modified_user_info).and_call_original
    end

    it 'creates a new user session for GitHub user' do
      post :github
      expect(User).to have_received(:find_by)
      expect(controller).to have_received(:create_github_user).with(user_info.merge('provider' => 'github'))
      expect(session[:current_user_id]).not_to be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET #login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'GET #logout' do
    it 'clears the current_user_id session and redirects to root_path' do
      session[:current_user_id] = 123
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end
end
