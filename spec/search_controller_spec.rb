# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    let(:civic_info_service_double) { nil }

    before do
      allow(Google::Apis::CivicinfoV2::CivicInfoService)
        .to receive(:new)
        .and_return(civic_info_service_double)
    end

    it 'default boilerplate for testing search' do
      expect(civic_info_service_double).to be_nil
    end
  end
end
