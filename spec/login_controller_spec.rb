# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
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
