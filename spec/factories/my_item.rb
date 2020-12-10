FactoryBot.define do
  factory :my_item do
    item_name { Faker::Lorem.characters(number:10) }
    maker { Faker::Lorem.characters(number:10) }
    user
  end
end