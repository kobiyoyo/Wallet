class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  belongs_to :currency
end
