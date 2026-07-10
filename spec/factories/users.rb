FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:uid) { |n| "steam_uid_#{n}" }
  end
end
