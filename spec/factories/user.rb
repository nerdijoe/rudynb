FactoryGirl.define do
  factory :user do
    firstname     { Faker::Name.first_name }
    lastname    { Faker::Name.last_name }
    email  { Faker::Internet.free_email }
    phone         { Faker::PhoneNumber.phone_number }
    nationality      { 'American' }
    password       { "haha" }
  end
end
