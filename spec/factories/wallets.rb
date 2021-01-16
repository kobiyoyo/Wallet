FactoryBot.define do
  factory :wallet do
    amount { "9.99" }
    main { false }
    user { nil }
    currency { nil }
  end
end
