FactoryBot.define do
  factory :transaction do
    transaction_type { 1 }
    description { "MyString" }
    amount { "9.99" }
    status { "MyString" }
    confirm { false }
    user { nil }
    wallet { nil }
    currency { nil }
  end
end
