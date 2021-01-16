class WalletSerializer < ActiveModel::Serializer
  attributes :id, :amount, :main
  has_one :user
  has_one :currency
end
