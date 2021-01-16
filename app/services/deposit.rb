class Deposit < TransactionAction
  # deposit funds to wallet
  def create(transaction_params, current_user)
    if current_user.admin?
      if !transaction_params.wallet_id
        notification = { message: 'Please provide a wallet to deduct from' }
        notification
      elsif !transaction_params.currency_id
        notification = { message: 'Please provide a currency' }
        notification
      else
        transaction_params.status = 'successful'
        add_to_wallet(transaction_params.user_id, transaction_params.wallet_id, transaction_params.amount, transaction_params.currency_id, current_user)
        check_status(transaction_params)
      end

    elsif current_user.noob?
      transaction_params.user_id = current_user.id
      transaction_params.confirm = false
      transaction_params.status = 'pending'
      if !transaction_params.wallet_id
        notification = { message: 'Please provide a wallet to deduct from' }
      elsif !transaction_params.currency_id
        notification = { message: 'Please provide a currency' }
      else
        notification = { message: 'Deposit has been sent for approval' }
        transaction_params.save
      end
      notification
    else
      if !transaction_params.currency_id
        notification = { message: 'Please provide a currency' }
      else
        transaction_params.user_id = current_user.id
        transaction_params.confirm = true
        transaction_params.status = 'successful'
        add_to_wallet(current_user.id, transaction_params.wallet_id, transaction_params.amount, transaction_params.currency_id, current_user)
        check_status(transaction_params)
    end
    end
  end
end
