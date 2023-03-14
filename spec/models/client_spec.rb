require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'Relations' do
    it { is_expected.to(have_many(:bank_accounts)) }
  end
end
