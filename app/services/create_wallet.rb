class CreateWallet
  def create(wallet, current_user)
    wallet_exist = Wallet.find_by(user_id: current_user.id, main: true)
    if wallet_exist
      if wallet.main == true
        response = { message: 'Unauthorized:You are not allowed to create another main wallet' }
        response
      elsif current_user.noob?
        response = { message: 'Unauthorized:Noob User can only have one wallet' }
        response
      else
        wallet
      end
    else
      if current_user.noob?
        wallet_exist = Wallet.find_by(user_id: current_user.id)
        if wallet_exist
          response = { message: 'Unauthorized:Noob User can only have one wallet' }
          response
        else
          wallet
        end
      else
        wallet
      end
    end
  end
end
