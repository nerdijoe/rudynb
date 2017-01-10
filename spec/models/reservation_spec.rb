require 'rails_helper'

RSpec.describe Reservation, type: :model do

  let(:valid_num_guest) {3}
  let(:invalid_num_guest) {10}

  let(:valid_start_date) {Date.new(2017,1,22)}
  let(:valid_end_date) {Date.new(2017,1,25)}

  let(:valid_start_date_test) {Date.new(2017,1,8)}
  let(:valid_end_date_test) {Date.new(2017,1,11)}

  let(:invalid_start_date) {Date.new(2017,1,9)}
  let(:invalid_end_date) {Date.new(2017,1,10)}

  let(:listing) {FactoryGirl.create(:listing)}
  let(:r1) { Reservation.create(num_guests: 3, start_date: Date.new(2017,1,8), end_date: Date.new(2017,1,11), listing_id: listing.id, user_id: listing.user_id) }

  context "valid params" do
    it "validates valid num_guests" do
      r1 = Reservation.create(num_guests: 3, start_date: valid_start_date_test, end_date: valid_end_date_test, listing_id: listing.id, user_id: listing.user_id)

      r2 = Reservation.create(num_guests: valid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: listing.id, user_id: listing.user_id)
      expect(r2).to be_valid
    end

    it "validates overlap dates with valid dates" do
      r1 = Reservation.create(num_guests: valid_num_guest, start_date: valid_start_date_test, end_date: valid_end_date_test, listing_id: listing.id, user_id: listing.user_id)

      r2 = Reservation.create(num_guests: valid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: listing.id, user_id: listing.user_id)

      expect(r2).to be_valid
    end
  end


  context "invalid params" do
    it "validates invalid_num_guest" do
      r1 = Reservation.create(num_guests: 3, start_date: valid_start_date_test, end_date: valid_end_date_test, listing_id: listing.id, user_id: listing.user_id)

      r2 = Reservation.create(num_guests: invalid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: listing.id, user_id: listing.user_id)
      expect(r2).to be_invalid
    end

    it "validates overlap dates with invalid dates" do
      r1 = Reservation.create(num_guests: valid_num_guest, start_date: valid_start_date_test, end_date: valid_end_date_test, listing_id: listing.id, user_id: listing.user_id)

      # need to assign r2.listing_id to the same listing as r1.listing.id
      r2 = Reservation.create(num_guests: valid_num_guest, start_date: invalid_start_date, end_date: invalid_end_date, listing_id: listing.id, user_id: listing.user_id)

      expect(r2).to be_invalid
    end
  end

end
