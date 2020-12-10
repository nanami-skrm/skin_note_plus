FactoryBot.define do
  factory :review do
    score {5}
    review_text { Faker::Lorem.characters(number:20) }
    user
    item
  end
end
