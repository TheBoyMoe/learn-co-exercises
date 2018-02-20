FactoryBot.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end
