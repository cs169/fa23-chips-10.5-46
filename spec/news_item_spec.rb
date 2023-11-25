# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe '.find_for' do
    it 'returns nil when no NewsItem is found' do
      representative_id = 1
      allow(described_class).to receive(:find_by).with(representative_id: representative_id).and_return(nil)
      result = described_class.find_for(representative_id)
      expect(result).to be_nil
    end
  end
end
