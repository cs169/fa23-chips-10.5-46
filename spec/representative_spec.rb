require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:office_info) { double('Office', name: 'Mayor', division_id: 'ocd-division/country:us/state:ny') }
    let(:official) { double('Official', name: 'John Doe') }
    let(:rep_info) do
      double('RepInfo', 
             officials: [official],
             offices: [double('OfficeItem', official_indices: [0], name: office_info.name, division_id: office_info.division_id)])
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .to change(Representative, :count).by(1)

        rep = Representative.last
        expect(rep.name).to eq('John Doe')
        expect(rep.ocdid).to eq('ocd-division/country:us/state:ny')
        expect(rep.title).to eq('Mayor')
      end
    end

    context 'when the representative already exists' do
      before do
        Representative.create!(name: 'Existing Rep', ocdid: 'ocd-division/country:us/state:ny', title: 'Former Mayor')
      end

      it 'updates the existing representative' do
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .not_to change(Representative, :count)

        rep = Representative.find_by(ocdid: 'ocd-division/country:us/state:ny')
        expect(rep.name).to eq('John Doe')
        expect(rep.title).to eq('Mayor')
      end
    end
  end
end
