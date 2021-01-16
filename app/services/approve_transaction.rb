class ApproveTransaction
  # Approve transactions for admin
  def create(updated_transaction)
    if updated_transaction.confirm == true
      wallet = Wallet.find(updated_transaction.wallet.id)
      wallet_abbreviation = wallet.currency.abbreviation
      transaction_abbreviation = updated_transaction.currency.abbreviation
      amount = updated_transaction.amount
      if wallet_abbreviation == transaction_abbreviation
        wallet.increment(:amount, amount)
      else
        exchanged_currency = CurrencyExchange.new.create(transaction_abbreviation, wallet_abbreviation)
        new_amount = exchanged_currency * amount
        wallet.increment(:amount, new_amount)
      end
      wallet.save
      updated_transaction.update(status: 'approved')
    elsif updated_transaction.confirm == false
      updated_transaction.update(status: 'declined')
    end
  end
end
