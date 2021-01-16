class Transaction < ApplicationRecord
  # Transcation Type
  TYPE = %i[deposit withdraw].freeze
  enum transaction_type: TYPE

  # Relationship
  belongs_to :user
  belongs_to :wallet, optional: true
  belongs_to :currency

  # Validation
  validates :transaction_type, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :amount, presence: true
  validates :status, presence: true
end
