class Wallet < ApplicationRecord
  # Relationship
  belongs_to :user
  belongs_to :currency
  has_many :transactions

  # Validation
  validates :amount, presence: true
end
