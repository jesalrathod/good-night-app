FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "MyStrinngg#{n}" }
  end
end
