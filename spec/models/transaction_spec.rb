require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:wallet).optional}
    it { should belong_to(:currency)}
    it { should belong_to(:user)}
  end

  describe 'validations' do
    it { should validate_presence_of(:transaction_type) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of (:description) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:status) }

  end
end
