# frozen_string_literal: true

require 'httparty'

class CampaignFinancesController < ApplicationController
  def index
    # pass
  end

  def search
    cycle = params[:cycle]
    category = params[:category]
    key = Rails.application.credentials[:PROPUBLICA_API_KEY]
    if cycle.present? && category.present?
      api_url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
      response = HTTParty.get(api_url, headers: { 'X-API-Key' => key })
      if response.success?
        @results = response.parsed_response['results']
      else
        @error_message = 'Error from ProPublica API'
      end
    else
      @error_message = 'Make sure cycle and category are both selected'
    end
    render 'campaign_finances/search'
  end
end
