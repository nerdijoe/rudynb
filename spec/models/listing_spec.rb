require 'rails_helper'

RSpec.describe Listing, type: :model do
  it "has a valid factory" do
    expect(create(:listing)).to be_valid
  end
end


describe Listing do
    # it { is_expected.to validate_presence_of(:title) }
    # it { is_expected.to validate_presence_of(:max_guests) }
    # it { is_expected.to validate_presence_of(:num_bedrooms) }
    # it { is_expected.to validate_presence_of(:price) }
end
