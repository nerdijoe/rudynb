FactoryGirl.define do
  factory :listing do
    user
    title         { Faker::Name.name }
    max_guests    { 5 }
    num_bedrooms  { 5 }
    price         { 100 }
    currency      { 'USD' }
    phone         { Faker::PhoneNumber.phone_number }
    address       { Faker::Address.street_address }
  end
end
