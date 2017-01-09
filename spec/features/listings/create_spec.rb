require 'rails_helper'

RSpec.feature "Listing", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}

  before do
    sign_in_as(user)
  end

  scenario "Create a new listing" do
    visit new_listing_path

    fill_in "listing_title", :with => Faker::Name.name
    fill_in "Phone", :with => "123456789"
    fill_in "Address", :with => Faker::Address.street_address
    fill_in "City", :with => Faker::Address.city
    fill_in "Max guests", :with => 5
    fill_in "Num of Bedrooms", :with => 5
    fill_in "Price", :with => 100
    fill_in "Currency", :with => "USD"
    fill_in "Price", :with => 100


    click_button "Create!"

    # expect(page).to have_text("My Name")
  end
end
