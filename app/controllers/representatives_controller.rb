# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def by_county
    county = params[:county]
    @representatives = Representative.where(county: county)
    respond_to do |format|
      format.js { render partial: 'representatives/list', locals: { representatives: @representatives } }
    end
  end
end
