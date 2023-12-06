# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :model do
  describe 'issues attribute' do
    before do
      @issue = 'Climate Change'
      @news_item = NewsItem.create(
        title: 'Test Title',
        issue: issue
      )
    end
    it 'allows setting and retrieving issues' do
      retrieved_issues = @news_item.issue
      expect(retrieved_issues).to eq(@issue)
    end
  end
end