FactoryBot.define do
  factory :wallet do
    amount { 'MyString' }
    main { false }
    user { nil }
    currency { nil }
  end
end
