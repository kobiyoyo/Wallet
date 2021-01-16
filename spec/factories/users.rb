FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    role { 1 }
    active { false }
    phone { "MyString" }
    password_digest { "MyString" }
  end
end
