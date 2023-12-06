# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinancesController, type: :controller do
  describe '#search' do
    context 'with valid parameters' do
      it 'returns success' do
        allow(HTTParty).to receive(:get).and_return(instance_double(HTTParty::Response, success?: true,
           parsed_response: { 'results' => [] }))
        get :search, params: { cycle: '2022', category: 'some_category' }
        expect(response).to have_http_status(:success)
        expect(assigns(:results)).to be_an(Array)
      end
    end
  end
end
