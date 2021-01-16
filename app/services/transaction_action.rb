class TransactionAction
  def check_status(transaction_status)
    if transaction_status.save
      transaction_status
    else
      transaction_status.errors
    end
  end

  # Add amount to wallet
  def add_to_wallet(user_id, wallet_id, amount, currency_id, current_user)
    wallet = Wallet.find_by(user_id: user_id, id: wallet_id)
    wallet_abbreviation = wallet ? wallet.currency.abbreviation : nil
    transaction_abbreviation = Currency.find(currency_id).abbreviation
    if current_user.elite?
      if wallet
        wallet.increment(:amount, amount)
        wallet.save
      else
        wallet = Wallet.create(amount: amount, user_id: current_user.id, currency_id: currency_id, main: false)
      end

    elsif current_user.noob?
      if wallet_abbreviation == transaction_abbreviation
        wallet.increment(:amount, amount)
      else
        exchanged_currency = CurrencyExchange.new.create(transaction_abbreviation, wallet_abbreviation)
        new_amount = exchanged_currency * amount
        wallet.increment(:amount, new_amount)
      end
      wallet.save
    else
      wallet.increment(:amount, amount)
      wallet.save
    end
  end

  # Reduce amount to wallet
  def deduct_from_wallet(user_id, wallet_id, amount, abbreviation, current_user)
    wallet = Wallet.find_by(user_id: user_id, id: wallet_id)
    wallet_abbreviation = wallet ? wallet.currency.abbreviation : nil
    transaction_abbreviation = Currency.find(abbreviation).abbreviation
    if current_user.elite?
      if wallet
        wallet.decrement(:amount, amount)
        check_wallet_balance(wallet)
      else
        main_wallet = Wallet.find_by(user_id: user_id, main: true)
        main_wallet.decrement(:amount, amount)
        check_wallet_balance(main_wallet)
      end

    elsif current_user.noob?
      if wallet_abbreviation == transaction_abbreviation
        wallet.decrement(:amount, amount)
        check_wallet_balance(wallet)
      else
        exchanged_currency = CurrencyExchange.new.create(transaction_abbreviation, wallet_abbreviation)
        new_amount = exchanged_currency * amount
        wallet.decrement(:amount, new_amount)
        check_wallet_balance(wallet)
      end
    end
  end

  # check for negative balance before withdraw
  def check_wallet_balance(wallet)
    if wallet.amount <= 5
      notification = { message: "Insufficient fund: you cant withdraw below 5 #{wallet.currency.abbreviation}" }
      notification
    else
      wallet.save
    end
  end
end
