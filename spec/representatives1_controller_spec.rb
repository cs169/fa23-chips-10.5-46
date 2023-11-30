# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :request do
  describe 'GET /representatives/:id' do
    before do
      rep_info = OpenStruct.new(
        name: 'John Doe', ocdid: '1', title: 'rep title',
        address: '123 Main St', party: 'Party A',
        photo: 'https://example.com/image.jpg'
      )
      allow(described_class).to receive(:find).and_return(rep_info)
      get representative_path(1)
    end

    it 'responds with HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes the representative’s details in the response' do
      expect(response.body).to include('John Doe')
      expect(response.body).to include('123 Main St')
      expect(response.body).to include('Party A')
    end
  end
end
