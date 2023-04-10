FactoryBot.define do
  factory :follow do
    follower_id { rand(1..100) }
    followee_id { rand(1..100) }
  end
end
