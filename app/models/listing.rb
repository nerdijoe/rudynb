require 'ffaker'

class Listing < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :reservations, :dependent => :destroy

  validates :user, presence: true

  validates :title, presence: true
  validates :max_guests, presence: true
  validates :num_bedrooms, presence: true
  validates :price, presence: true
  validates :currency, presence: true


  acts_as_taggable # Alias for acts_as_taggable_on :tags
  # acts_as_taggable_on :skills, :interests

  mount_uploaders :photos, ImageUploader

  scope :city,          -> (city) { where(city: city) }
  scope :num_guests,    -> (num_guests) { where('max_guests >= ?', num_guests) }
  scope :num_bedrooms,  -> (num_bedrooms) { where('num_bedrooms >= ?', num_bedrooms) }
  scope :min_price,     -> (min_price) { where('price >= ?', min_price) }
  scope :max_price,     -> (max_price) { where('price <= ?', max_price) }

  include PgSearch
  pg_search_scope :search_by_keyword, :against => [:title, :description, :address, :house_rules]

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
