
require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'creates and updates representatives' do
      existing_rep = Representative.create(name: 'John Doe', ocdid: 'existing_ocdid', title: 'Existing Title')

      rep_info = OpenStruct.new(
        officials: [
          OpenStruct.new(name: 'John Doe'),
          OpenStruct.new(name: 'Jane Smith')
        ],
        offices: [
          OpenStruct.new(official_indices: [0], name: 'Mayor', division_id: 'xyz'),
          OpenStruct.new(official_indices: [1], name: 'Governor', division_id: 'abc')
        ]
      )

      reps = Representative.civic_api_to_representative_params(rep_info)

      expect(reps).not_to be_empty
      reps.each do |rep|
        expect(rep).to be_a(Representative)
        expect(rep.name).not_to be_nil
        expect(rep.ocdid).not_to be_nil
        expect(rep.title).not_to be_nil
      end

      existing_rep.reload
      expect(Representative.count).to eq(2)

    end
  end
end