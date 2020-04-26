FactoryBot.define do
  factory :ledger do
    name { Faker::Name.unique.name }
    starting_balance { 1000 }
  end
end
