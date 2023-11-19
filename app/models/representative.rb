# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.each_with_index.map do |official, index|
      office_info = find_office_info_for_rep(rep_info.offices, index)
      rep = Representative.find_or_initialize_by(ocdid: office_info.division_id)
      rep.update(name: official.name, title: office_info.name)
      rep
    end
  end
  

  private

  def self.find_office_info_for_rep(offices, index)
    offices.find { |office| office.official_indices.include? index }
  end

  def self.create_representative(official, office_info)
    Representative.create({ name: official.name, ocdid: office_info&.division_id,
                            title: office_info&.name })
  end
end

