FactoryBot.define do
  factory :transaction do
    transaction_type { 'withdraw' }
    description { 'MyString' }
    amount { 'MyString' }
    status { 'MyString' }
    confirm { false }
    user { nil }
    wallet { nil }
  end
end
