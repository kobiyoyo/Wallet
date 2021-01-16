class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :role, :active, :phone, :password_digest
end
