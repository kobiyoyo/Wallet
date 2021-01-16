class Api::V1::CurrenciesController < ApplicationController
  before_action :authorize_admin, only: [:create]
  # GET /currencies
  def index
    @currencies = Currency.all
    render json: @currencies
  end

  # POST /currencies
  def create
    @currency = Currency.new(currency_params)

    if @currency.save
      render json: @currency, status: :created
    else
      render json: @currency.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def currency_params
    params.permit(:name, :abbreviation)
  end
end
