def create_transaction(user, wallet, currency)
  FactoryBot.create(
    :transaction,
    user: user,
    wallet: wallet,
    currency: currency,
    description: 'phone money i am saving'
  )
end

def create_wallet(user, currency)
  FactoryBot.create(
    :wallet,
    user: user,
    currency: currency
  )
end
