FactoryBot.define do
  factory :ledger do
    name { 'Test Ledger' }
    starting_balance { 1000 }
  end
end
