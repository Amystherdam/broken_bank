require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'Relations' do
    it { is_expected.to(belong_to(:client)) }
  end

  describe 'Enums' do
    it { is_expected.to(define_enum_for(:status).with_values(%i[active closed])) }
  end
end
