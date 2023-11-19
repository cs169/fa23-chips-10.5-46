# frozen_string_literal: true

require 'rails_helper'

officials_m = [
  OpenStruct.new(name: 'John Doe'),
  OpenStruct.new(name: 'Jane Smith')
]

offices_m = [
  OpenStruct.new(official_indices: [0], name: 'Mayor', division_id: 'xyz'),
  OpenStruct.new(official_indices: [1], name: 'Governor', division_id: 'abc')
]

rep_info = OpenStruct.new(officials: officials_m, offices: offices_m)

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'creates and updates representatives' do
      existing_rep = described_class.create(name: 'John Doe', ocdid: 'existing_ocdid', title: 'Existing Title')
      described_class.civic_api_to_representative_params(rep_info)
      existing_rep.reload
      expect(described_class.count).to eq(2)
    end
  end
end
