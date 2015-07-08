FactoryGirl.define do
  factory :user do
    name 'John Doe'
    email 'johndoe@example.com'
    password '123123123'
    password_confirmation '123123123'
  end

end
