require "rails_helper"
# require_relative "../../app/controllers/listings_controller.rb"

RSpec.describe ListingsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  # let(:title) {'david house'}
  # let(:max_guests) {5}
  # let(:num_bedrooms) {5}
  # let(:price) {100}
  # let(:currency) {'USD'}
  # let(:listing2) {Listing.new(title: title, max_guests: max_guests, num_bedrooms: num_bedrooms, price: price, currency: currency)}

  let(:valid_listing_params) {{title: 'BIG house',max_guests: 10, num_bedrooms: 10, price: 100, currency: 'USD', user_id: user.id }}
  let(:invalid_listing_params) {{title: 'BIG house', num_bedrooms: 10, price: 100, currency: 'USD', user_id: user.id }}

  let(:invalid_update_listing_params) {{title: '',max_guests: 10, num_bedrooms: 10, price: 100, currency: 'USD', user_id: user.id }}


  describe "GET #new" do
    before do
      sign_in_as(user)
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns instance listing" do
      expect(assigns[:listing]).to be_a Listing
    end

  end

  describe "POST #create" do
    before do
      sign_in_as(user)
    end

    context "valid_params" do
      it "create a new listing" do
        # expect(Listing.new(title: 'david mansion', max_guests: 20, num_bedrooms: 10, price: 5000, currency: 'USD')).to be_a_kind_of(Listing)

        expect(FactoryGirl.create(:listing)).to be_a_kind_of(Listing)
      end

      it "creates new listing if params are correct" do
        expect {post :create, :listing => valid_listing_params}.to change(Listing, :count).by(1)
      end

      it "redirects to user_listings_path" do
        post :create, :listing => valid_listing_params
        expect(response).to redirect_to(user_listings_path(user.id))
        expect(flash[:notice]).to eq "Your listing has been created"
      end
    end

    context "invalid_params" do
      it "does not create a new listing if params are incorrect" do
        expect {post :create, :listing => invalid_listing_params}.to change(Listing, :count).by(0)
      end

      it "redirects to new_listing_path" do
        post :create, :listing => invalid_listing_params
        expect(response).to render_template('new')
        expect(flash[:alert]).to eq "Your listing is not created"
      end
    end

  end

  describe "GET #show" do
    before do
      sign_in_as(user)
      listing = FactoryGirl.create(:listing)
      get :show, {:id => listing.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "assigns instance listing and reservation" do
      expect(assigns[:listing]).to be_a Listing
      expect(assigns[:reservation]).to be_a Reservation
    end

  end

  describe "GET #edit " do
    before do
      sign_in_as(user)
      listing = FactoryGirl.create(:listing)
      get :edit, {:id => listing.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
      expect(assigns[:listing]).to be_a Listing
    end
  end

  describe "PUT #update" do
    before do
      sign_in_as(user)
    end

    context "with valid update params" do
      it "updates the requested listing" do
        listing = FactoryGirl.create(:listing)
        put :update, {id: listing.id, listing: valid_listing_params}
        listing.reload
        expect(listing.title).to eq valid_listing_params[:title]
      end

      it "redirects to listing path" do
        listing = FactoryGirl.create(:listing)
        put :update, {id: listing.id, listing: valid_listing_params}
        listing.reload
        expect(response).to redirect_to(listing_path(listing))
        expect(flash[:notice]).to eq "Listing has been updated"
      end
    end

    #unhappy path
    context "with invalid update params" do

      it "re-renders the 'edit' template" do
        listing = FactoryGirl.create(:listing)
        put :update, {id: listing.id, listing: invalid_update_listing_params}
        # expect(response).to redirect_to(listing_path(listing))
        expect(response).to render_template('edit')
      end
    end

  end

  describe "DELETE #destroy" do
    before do
      sign_in_as(user)
    end

    it "destroys the requested listing" do
      listing = FactoryGirl.create(:listing)
      expect { delete :destroy, {id: listing.id}}.to change(Listing, :count).by(-1)
    end

    it "redirects to the statuses_path" do
      listing = FactoryGirl.create(:listing)
      delete :destroy, {id: listing.id}
      expect(response).to redirect_to(listings_path)
      expect(flash[:notice]).to eq "Your listing has been deleted."
    end


  end


end
