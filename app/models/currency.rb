class Currency < ApplicationRecord
  # Relationship
  has_many :wallets
  has_many :transactions

  # Validation
  validates :name, presence: true
  validates :abbreviation, presence: true, length: { minimum: 3 }, uniqueness: true
end
