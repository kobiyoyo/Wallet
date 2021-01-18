class CreateWallet
  def create(wallet, current_user)
    wallet.main = false
    if current_user.noob?
      response = { message: 'Unauthorized:Noob User can only have one wallet' }
      response
    else
      wallet
    end
  end
end
