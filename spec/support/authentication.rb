class Auth
  def authenticated_header(users)
    token = JsonWebToken.encode(user_id: users.id)

    {
      'Authorization': "Bearer #{token}"
    }
  end

  def token(users)
    JsonWebToken.encode(user_id: users.id)
  end
end
