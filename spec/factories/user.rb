FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:10) }
    age {"20"}
    skin_type {0}
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
