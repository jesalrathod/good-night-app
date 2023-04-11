FactoryBot.define do
  factory :clock do
    clock_in_time { "2023-04-11 16:56:39" }
    clock_out_time { "2023-04-11 16:56:39" }
    user { nil }
  end
end
