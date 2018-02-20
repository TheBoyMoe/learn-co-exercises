FactoryBot.define do
  factory :post do
    content "content"
    association :user
  end
end
