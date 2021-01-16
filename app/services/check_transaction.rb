class CheckTransaction
  # Check transaction type
  def action(transaction_params, current_user)
    if transaction_params.transaction_type == 'deposit'
      Deposit.new.create(transaction_params, current_user)
    elsif transaction_params.transaction_type == 'withdraw'
      Withdraw.new.create(transaction_params, current_user)
    end
  end
end
