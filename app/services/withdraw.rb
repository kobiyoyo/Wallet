class Withdraw < TransactionAction
  # Withdraw funds from wallet
  def create(transaction_params, current_user)
    if current_user.admin?
      notification = { message: 'Unauthorised: Only Noobs and Elite users can withdraw!' }
      render json: notification
    elsif current_user.noob?
      if !transaction_params.wallet_id
        notification = { message: 'Please provide a wallet to deduct from' }
        notification
      elsif !transaction_params.currency_id
        notification = { message: 'Please provide a currency' }
        notification
      else
        transaction_params.user_id = current_user.id
        transaction_params.status = 'successful'
        insufficient_fund = deduct_from_wallet(transaction_params.user_id, transaction_params.wallet_id, transaction_params.amount, transaction_params.currency_id, current_user)
        insufficient_fund || check_status(transaction_params)
      end

    else
      if !transaction_params.currency_id
        notification = { message: 'Please provide a currency' }
        notification
      else
        transaction_params.user_id = current_user.id
        transaction_params.status = 'successful'
        insufficient_fund = deduct_from_wallet(transaction_params.user_id, transaction_params.wallet_id, transaction_params.amount, transaction_params.currency_id, current_user)
        insufficient_fund.class == Hash ? insufficient_fund : check_status(transaction_params)
      end
    end
  end
end
