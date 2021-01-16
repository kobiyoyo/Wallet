require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:wallets)}
    it { should have_many(:transactions)}
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of (:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of (:last_name) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of (:password_digest) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:role) }
  end
end
