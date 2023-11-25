# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      existing_rep = Representative.find_by(name: official.name)

      if existing_rep
        #existing_rep.update({ ocdid: ocdid_temp, title: title_temp })
        reps.push(existing_rep)
      else
        official_address = official.address
        if official_address.nil?
          concatenated_address = ''
        else
          concatenated_address = "#{official_address[0].line1}, #{official_address[0].city}, #{official_address[0].state} #{official_address[0].zip}"
        end
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp, address: concatenated_address, party: official.party, photo: official.photo_url })
        reps.push(rep)
      end
    end

    reps
  end
end
