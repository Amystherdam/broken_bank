require 'rails_helper'

RSpec.describe BankAccountHelper, type: :helper do
  describe '#cent_to_real' do
    it 'converts cents to real format' do
      expect(helper.cent_to_real(100)).to eq('1,00')
      expect(helper.cent_to_real(12345)).to eq('123,45')
      expect(helper.cent_to_real(999999)).to eq('9.999,99')
    end
  end
end
