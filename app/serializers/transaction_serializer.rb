class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_type, :description, :amount, :status, :confirm
  has_one :user
  has_one :wallet
  has_one :currency
end
