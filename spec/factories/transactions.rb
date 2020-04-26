FactoryBot.define do
	factory :transaction do
		ledger
		amount { rand(1000) }
		date { '2020-04-26' }
		tr_type { 'expenses' }
	end

	factory :expenses_transaction, parent: :transaction do
		tr_type { 'expenses' }
	end

	factory :revenues_transaction, parent: :transaction do
		tr_type { 'revenues' }
	end
end
