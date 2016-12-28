require 'ffaker'

class Listing < ActiveRecord::Base
  belongs_to :user

  attr_accessor :tag_list

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  # acts_as_taggable_on :skills, :interests


  def tag_list
    self.tags.map { |t| t.name }.join(", ")
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/,\s+/)
    self.tags = tag_names.map { |name| ActsAsTaggableOn::Tag.where('name = ?', name).first or ActsAsTaggableOn::Tag.create(:name => name) }
  end


  def self.populate

    5.times do |n|
     title =  FFaker::Movie.title
     description =  FFaker::HipsterIpsum.sentence
     address = FFaker::AddressUS.street_address
     country  = FFaker::AddressUS.country
     phone = FFaker::PhoneNumber.phone_number
     num_bedrooms =  (rand * 3).to_i
     price = (rand * 100).to_i
     currency = "USD"
     house_rules = FFaker::HipsterIpsum.paragraph

     listing = Listing.create!(
       title: title,
       description: description,
       address: address,
       country: country,
       phone: phone,
       num_bedrooms: num_bedrooms,
       price: price,
       currency: currency,
       house_rules: house_rules
     )
     listing.tag_list = FFaker::CheesyLingo.word

    end
  end

end
