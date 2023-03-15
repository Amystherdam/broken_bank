module BankAccountHelper
  def cent_to_real(cents)
    number_with_precision(cents/100.0, precision: 2, separator: ',', delimiter: '.')
  end
end
