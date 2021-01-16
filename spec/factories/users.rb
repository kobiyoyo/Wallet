FactoryBot.define do
  factory :user do
    first_name { 'MyString' }
    last_name { 'MyString' }
    role { 'admin' }
    active { 'MyString' }
    email { 'add@gmail.com' }
    password_digest { 'MyString' }
  end
end
