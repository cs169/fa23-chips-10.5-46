# frozen_string_literal: true

require 'rails_helper'

STATE_CLASS = 'State'
COUNTY_CLASS = 'County'

RSpec.describe MapController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #state' do
    let(:state) { instance_double(STATE_CLASS, symbol: 'CA') }
    let(:county) { instance_double(COUNTY_CLASS, std_fips_code: '12345') }

    it 'renders the state template' do
      allow(State).to receive(:find_by).with(symbol: 'CA').and_return(state)
      allow(state).to receive(:counties).and_return([county])
      allow(county).to receive(:index_by).and_return({ county.std_fips_code => county })
      get :state, params: { state_symbol: 'CA' }
      expect(response).to render_template(:state)
    end

    it 'assigns @state and @county_details' do
      allow(State).to receive(:find_by).with(symbol: 'CA').and_return(state)
      allow(state).to receive(:counties).and_return([county])
      allow(county).to receive(:index_by).and_return({ county.std_fips_code => county })
      get :state, params: { state_symbol: 'CA' }
      expect(assigns(:county_details)).to eq({ county.std_fips_code => county })
    end

    it 'redirects to root_path if state not found' do
      allow(State).to receive(:find_by).with(symbol: 'NY').and_return(nil)
      get :state, params: { state_symbol: 'NY' }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("State 'NY' not found.")
    end
  end
end
