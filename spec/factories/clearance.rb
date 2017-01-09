FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user1 do
    email
    password "password"
  end
end
