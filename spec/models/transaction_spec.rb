require 'rails_helper'

RSpec.describe Transaction, type: :model do
	let(:ledger) { create(:ledger) }
	let(:transaction) { create(:transaction, ledger: ledger) }

	it 'should have associations' do
		expect(transaction).to belong_to(:ledger)
	end
end
