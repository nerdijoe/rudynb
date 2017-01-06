require 'rails_helper'

describe "user login" do
  it "redirects user to index" do
    user = FactoryGirl.build_stubbed(:user)
    visit root_path
    click_button "Sign in now"

    within('#myModal') do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign in"
      current_path.should eq(sign_in_path)
      # page.should have_content('a_modal_content_here') # async
    end

  end
end
