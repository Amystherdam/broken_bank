FactoryBot.define do
  sequence :email do |n|
    "client#{n}@example.com"
  end

  factory :client do
    email
    password { '12345678' }
  end
end
