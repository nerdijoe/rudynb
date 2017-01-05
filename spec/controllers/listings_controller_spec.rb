require "rails_helper"
# require_relative "../../app/controllers/listings_controller.rb"

RSpec.describe ListingsController, type: :controller do
  let(:title) {'david house'}
  let(:max_guests) {5}
  let(:num_bedrooms) {5}
  let(:price) {100}
  let(:currency) {'USD'}
  let(:listing) {Listing.new(title: title, max_guests: max_guests, num_bedrooms: num_bedrooms, price: price, currency: currency)}

  describe "#create" do
    it "create a new listing" do
      expect(Listing.new(title: 'david mansion', max_guests: 20, num_bedrooms: 10, price: 5000, currency: 'USD')).to be_a_kind_of(Listing)
    end
  end

  describe "#show" do
    it "returns the listing and new reservation objects"
  end

end
