class UserSignup
  # create user
  def create(user_params, currency_params_id)
    ActiveRecord::Base.transaction do
      if !currency_params_id
        notification = { message: 'Please provide a currency' }
        notification
      else
        user_params.save!
        Wallet.create!(user_id: user_params.id, currency_id: currency_params_id, main: true)
      end
    end
  end
end
