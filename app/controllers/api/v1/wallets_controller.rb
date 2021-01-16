class Api::V1::WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show update destroy]
  before_action :authorize_admin, only: %i[update]
  before_action :authorize_elite_or_noob, only: %i[index show create]

  # GET /wallets
  def index
    @wallets = @current_user.wallets.all
    render json: @wallets
  end

  # GET /wallets/1
  def show
    render json: @wallet
  end

  # POST /wallets
  def create
    @wallet = @current_user.wallets.build(wallet_params)
    create_wallet = CreateWallet.new
    if create_wallet.create(@wallet, @current_user).save
      render json: create_wallet.create(@wallet, @current_user)
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /wallets/1
  def update
    if @wallet.update(admin_can_change_currency_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wallets/1
  def destroy
    @wallet.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def wallet_params
    params.permit(:main, :user_id, :currency_id)
  end

  # admin could change the main currency of any wallet
  def admin_can_change_currency_params
    params.permit(:currency_id)
  end
end
