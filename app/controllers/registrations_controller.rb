class RegistrationsController < Devise::RegistrationsController
  def create
    super do |client|
      AccountRegistrationService.new(client).create_bank_account
    end
  end
end
