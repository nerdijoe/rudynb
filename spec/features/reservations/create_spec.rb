require 'rails_helper'

RSpec.feature "Reservation", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}
  let(:listing) {FactoryGirl.create(:listing)}
  let(:valid_reservation_params) {{num_guests: 3, start_date: Date.new(2017,1,22), end_date: Date.new(2017,1,25), user_id: user.id, listing_id: listing.id }}
  let(:invalid_reservation_params) {{num_guests: 10, start_date: Date.new(2017,1,22), end_date: Date.new(2017,1,25), user_id: user.id, listing_id: listing.id }}

  let(:valid_num_guest) {3}
  let(:invalid_num_guest) {10}

  let(:valid_start_date) {Date.new(2017,1,22)}
  let(:valid_end_date) {Date.new(2017,1,25)}

  let(:invalid_start_date) {Date.new(2017,1,9)}
  let(:invalid_end_date) {Date.new(2017,1,10)}


  before do
    visit root_path
    click_button "Sign in now"

    within('#myModal') do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign in"
    end
  end

  context "User create a reservation to the listing with valid data" do
    it "sucessfully creates a reservation" do
      visit listing_path(listing)
      fill_in "reservation_num_guests", with: valid_num_guest
      fill_in "reservation_start_date", with: valid_start_date
      fill_in "reservation_end_date", with: valid_end_date

      click_button "Book Now"

      expect(page).to have_content("#{user.email} Start #{valid_start_date}, End #{valid_end_date}, num guests #{valid_num_guest}")
    end
  end

  context "User create a reservation with invalid data" do
    context "using invalid num_guests" do
      it "show error message" do
        visit listing_path(listing)

        fill_in "reservation_num_guests", with: invalid_num_guest
        fill_in "reservation_start_date", with: valid_start_date
        fill_in "reservation_end_date", with: valid_end_date
        click_button "Book Now"

        expect(page).to have_text('Number of guests exceeded')

      end
    end
  end

end
