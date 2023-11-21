# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  describe 'GET #new' do
    it 'returns a redirect status' do
      get :new, params: { representative_id: 1 }
      expect(response).to have_http_status(:redirect)
    end
  end
end
