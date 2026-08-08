FactoryBot.define do
  factory :user_statistic_snapshot do
    user { nil }
    recorded_on { "2026-08-08" }
    total_price { 1 }
    unplayed_rate { "9.99" }
  end
end
