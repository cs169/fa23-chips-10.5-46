# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  describe 'get index' do
    representative = OpenStruct.new(id: 1, news_items: ['Climate Change'])
    before do
      allow(Representative).to receive(:find).and_return(representative)
      get :index, params: { representative_id: 1 }
    end

    it 'assigns @news_items' do
      expect(assigns(:news_items)).to eq(['Climate Change'])
    end
  end
end
