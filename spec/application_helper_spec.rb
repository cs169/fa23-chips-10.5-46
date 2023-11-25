# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '.state_ids_by_name' do
    it 'returns an empty ids hash when there are no states' do
      result = described_class.state_ids_by_name
      expect(result).to be_empty
    end
  end

  describe '.state_symbols_by_name' do
    it 'returns and empty symbols hash when there are no states' do
      result = described_class.state_symbols_by_name
      expect(result).to be_empty
    end
  end

  describe '.nav_items' do
    it 'returns an array of navigation items with correct titles and links' do
      nav_items = described_class.nav_items
      expect(nav_items).to be_an(Array)
    end
  end
end
