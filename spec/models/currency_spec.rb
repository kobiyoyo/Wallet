require 'rails_helper'

RSpec.describe Currency, type: :model do
   describe 'associations' do
    it { should have_many(:wallets)}
    it { should have_many(:transactions)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:abbreviation) }
    it { should validate_uniqueness_of(:abbreviation) }
    it { should validate_length_of (:abbreviation) }
  end
end
