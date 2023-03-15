require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  describe 'Relations' do
    it { is_expected.to(belong_to(:bank_account)) }
    it { is_expected.to(belong_to(:client)) }
  end

  describe 'Validations' do
    it { is_expected.to(validate_presence_of(:transaction_value)) }
    it { is_expected.to(validate_presence_of(:kind)) }
    it { is_expected.to(validate_presence_of(:bank_account)) }
    it { is_expected.to(validate_presence_of(:client)) }
  end

  describe 'Enums' do
    it { is_expected.to(define_enum_for(:kind).with_values(%i[deposit withdraw transfer])) }
  end
end
