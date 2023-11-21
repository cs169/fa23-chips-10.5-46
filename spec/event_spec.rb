# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'returns an empty hash if county or state is nil' do
      event = described_class.new
      allow(event).to receive(:county).and_return(nil)
      result = event.county_names_by_id
      expect(result).to be_empty
    end
  end
end
