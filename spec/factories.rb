FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    thirteen_or_older true
  end

  factory :profile do
    name 'John Doe'
    association :user
  end

  factory :message do
    association :profile
    association :from, :factory => :profile
  end
end
