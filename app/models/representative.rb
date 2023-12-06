# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.each_with_index.map do |official, index|
      process_representative(official, index, rep_info)
    end
  end

  def self.process_representative(official, index, rep_info)
    title_temp, ocdid_temp = find_office_info_for_rep(rep_info, index)
    existing_rep = Representative.find_by(name: official.name)

    existing_rep || create_new_representative(official, ocdid_temp, title_temp)
  end

  def self.find_office_info_for_rep(rep_info, index)
    ocdid_temp = ''
    title_temp = ''

    rep_info.offices.each do |office|
      if office.official_indices.include? index
        title_temp = office.name
        ocdid_temp = office.division_id
      end
    end

    [title_temp, ocdid_temp]
  end

  def self.create_new_representative(official, ocdid_temp, title_temp)
    official_address = official.address
    concatenated_address = if official_address.nil?
                             ''
                           else
                             "#{official_address[0].line1},
                             #{official_address[0].city},
                             #{official_address[0].state},
                             #{official_address[0].zip}"
                           end
    Representative.create!({
                             name:    official.name,
                             ocdid:   ocdid_temp,
                             title:   title_temp,
                             address: concatenated_address,
                             party:   official.party,
                             photo:   official.photo_url
                           })
  end
end
