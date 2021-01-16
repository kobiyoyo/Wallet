class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  before_action :set_user, only: %i[show update destroy]
  before_action :authorize_admin, only: %i[index show update]
  
  # POST /index
  def index
    @users = User.all.order('created_at DESC')
    render json: @users
  end

  # POST /create
  def create
    @user = User.new(user_params)
    signup = UserSignup.new
    user = signup.create(@user, params[:currency_id])
    render json: user
  end

  def show; end

  # PATCH/PUT api/v1/users/1
  def update
    if @user.update(admin_user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    authenticate params[:email], params[:password]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :phone
    )
  end

  # admin can promote or demote Noobs or Elite users
  def admin_user_params
    params.permit(
      :active,
      :role
    )
end
end
