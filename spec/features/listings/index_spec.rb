require 'rails_helper'

RSpec.feature "Listing", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}

  before do
    sign_in_as(user)
  end

  context "with number of listings <= 10" do
    it "does not paginate records" do
      FactoryGirl.create_list :listing, 10

      visit listings_path

      expect(page).to have_no_xpath("//*[@class='pagination']//a[text()='2']")
    end
  end

  context "with number of listings > 10" do
    before do
      FactoryGirl.create_list :listing, 11
      visit listings_path
    end
    it "paginates records" do
      expect(page).to have_xpath("//*[@class='pagination']//a[text()='2']")
    end

    it "set the current page marked as current" do
      # example:
      # <em class="current">1</em>

      expect(page).to have_css("em.current", text: "1")

    end

    it "set the current page to page 2 if user click next page" do
      click_link ">"
      expect(page).to have_css("em.current", text: "2")

    end
  end

end
