FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    task_genre { :tsumige }
  end
end
