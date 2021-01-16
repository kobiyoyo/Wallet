require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe 'associations' do
    it { should have_many(:transactions)}
    it { should belong_to(:currency)}
    it { should belong_to(:user)}
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }


  end
end
