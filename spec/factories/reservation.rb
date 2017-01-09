FactoryGirl.define do
  factory :reservation do
    num_guests     { 3 }
    start_date    { Faker::Date.between(1.day.ago, Date.today) }
    end_date  { Faker::Date.forward(3) }
    user
    listing
  end

end
