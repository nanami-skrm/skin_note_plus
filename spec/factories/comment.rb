FactoryBot.define do
  factory :comment do
    comment_text { Faker::Lorem.characters(number:10) }
    user
    tweet
  end
end
