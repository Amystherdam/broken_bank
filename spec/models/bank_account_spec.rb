require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'Relations' do
    it { is_expected.to(belong_to(:client)) }
  end
end
