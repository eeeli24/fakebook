FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    pwd = Faker::Internet.password(6)
    password { pwd }
    password_confirmation { pwd }
    country_code { Faker::Address.country_code }
    age { Random.rand(12..90) }
  end

end
