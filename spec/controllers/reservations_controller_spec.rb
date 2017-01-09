require "rails_helper"
require "clearance/rspec"

RSpec.describe ReservationsController, type: :controller do
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

  let(:login_params) {{email: user.email, password: user.password}}


  describe "POST #Create" do
    before do
      sign_in_as(user)
    end

    context "sucessfully made a reservation" do
      it "listing reservation will increase by 1" do
        expect {post :create, :listing_id => listing.id, :reservation => valid_reservation_params}.to change(listing.reservations, :count).by(1)

      end

      it "redirects to listing show page" do
        post :create, :listing_id => listing.id, :reservation => valid_reservation_params
        expect(response).to redirect_to(listing_path(listing.id))
      end
    end

    context "invalid num_guests" do
      it "listing reservation will not increase" do
        expect {        post :create, :listing_id => listing.id, :reservation => {num_guests: invalid_num_guest, start_date: valid_start_date, end_date: valid_start_date, user_id: user.id, listing_id: listing.id }}.to change(listing.reservations, :count).by(0)
      end

      it "redirects to listing show page" do
        post :create, :listing_id => listing.id, :reservation => {num_guests: invalid_num_guest, start_date: valid_start_date, end_date: valid_start_date, user_id: user.id, listing_id: listing.id }

        expect(response).to render_template("listings/show")

      end

    end
  end

end
