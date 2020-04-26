require 'rails_helper'

RSpec.describe Transaction, type: :model do
	let(:ledger) { create(:ledger) }
	let(:transaction) { create(:transaction, ledger: ledger) }

	context 'associations' do
		it 'should have associations' do
			expect(transaction).to belong_to(:ledger)
		end
	end

	context 'validations' do
		it 'validates' do
			is_expected.to validate_presence_of :ledger_id
			is_expected.to validate_presence_of :amount
			is_expected.to validate_presence_of :date
			is_expected.to validate_presence_of :tr_type
			is_expected.to validate_numericality_of(:amount)
			is_expected.to validate_inclusion_of(:tr_type).in_array(Transaction::VALID_TYPES)
		end

		context 'date format yyyy-mm-dd' do
			it { should allow_value("2020-01-31").for(:date) }
			it { should_not allow_value("2020-31-13").for(:date) }
		end
	end
end
