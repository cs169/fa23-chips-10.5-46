# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  after do
    described_class.destroy_all
  end

  describe 'name method' do
    it 'concatenates first_name and last_name' do
      user = described_class.new(first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq('John Doe')
    end
  end

  describe 'auth_provider method' do
    it 'returns "Google" for google_oauth2 provider' do
      user = described_class.new(provider: 'google_oauth2')
      expect(user.auth_provider).to eq('Google')
    end

    it 'returns "Github" for github provider' do
      user = described_class.new(provider: 'github')
      expect(user.auth_provider).to eq('Github')
    end
  end

  describe 'find_google_user method' do
    it 'finds a Google user by uid' do
      google_user = described_class.new(provider: 'google_oauth2', uid: 'google_uid')
      google_user.save
      found_user = described_class.find_google_user('google_uid')
      expect(found_user).to eq(google_user)
    end
  end

  describe 'find_github_user method' do
    it 'finds a Github user by uid' do
      github_user = described_class.new(provider: 'github', uid: 'github_uid')
      github_user.save
      found_user = described_class.find_github_user('github_uid')
      expect(found_user).to eq(github_user)
    end
  end
end
