FactoryBot.define do
  factory :item do
    item_name { Faker::Lorem.characters(number:10) }
    item_genre {0}
    maker { Faker::Lorem.characters(number:10) }
  end
end
