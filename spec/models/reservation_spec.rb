require 'rails_helper'

describe "Reservation" do
  let(:valid_num_guest) {3}
  let(:invalid_num_guest) {10}

  let(:valid_start_date) {Date.new(2017,1,22)}
  let(:valid_end_date) {Date.new(2017,1,25)}

  let(:invalid_start_date) {Date.new(2017,1,9)}
  let(:invalid_end_date) {Date.new(2017,1,10)}

  before do
  end


  it "validates valid num_guests" do
    listing = FactoryGirl.create(:listing)
    r2 = Reservation.new(num_guests: valid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: listing.id, user_id: listing.user_id)
    expect(r2.valid?).to be true
  end

  it "validates invalid_num_guest" do
    r1 = FactoryGirl.create(:reservation)

    listing = FactoryGirl.create(:listing)

    r2 = Reservation.new(num_guests: invalid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: r1.listing.id, user_id: listing.user_id)
    expect(r2.valid?).to be false
  end

  it "validates overlap dates with valid dates" do
    r1 = FactoryGirl.create(:reservation)

    listing = FactoryGirl.create(:listing)

    r2 = Reservation.new(num_guests: valid_num_guest, start_date: valid_start_date, end_date: valid_end_date, listing_id: r1.listing.id, user_id: listing.user_id)

    expect(r2.valid?).to be true
  end

  it "validates overlap dates with invalid dates" do
    r1 = FactoryGirl.create(:reservation)

    listing = FactoryGirl.create(:listing)

    # need to assign r2.listing_id to the same listing as r1.listing.id
    r2 = Reservation.new(num_guests: valid_num_guest, start_date: invalid_start_date, end_date: invalid_end_date, listing_id: r1.listing.id, user_id: listing.user_id)

    expect(r2.valid?).to be false
  end


end
