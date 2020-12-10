FactoryBot.define do
  factory :tweet do
    tweet_text { Faker::Lorem.characters(number:20) }
    user
  end
end