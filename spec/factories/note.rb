FactoryBot.define do
  factory :note do
    date {Date.today}
    condition {0}
    user
  end
end
