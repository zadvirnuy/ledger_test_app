require 'rails_helper'

RSpec.describe Ledger, type: :model do
  context 'associations' do
    it 'should have associations' do
      is_expected.to have_many :transactions
    end
  end

  context 'validations' do
    it 'validates' do
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :starting_balance
      is_expected.to validate_numericality_of(:starting_balance)
    end
  end

  context '#methods' do
    let!(:ledger) { create(:ledger) }
    let!(:expenses_tr1) { create(:expenses_transaction, ledger: ledger) }
    let!(:revenues_tr1) { create(:revenues_transaction, ledger: ledger) }
    let!(:expenses_tr2) { create(:expenses_transaction, ledger: ledger) }
    let!(:revenues_tr2) { create(:revenues_transaction, ledger: ledger) }

    context 'totals' do
      it 'returns ledger total expenses and revenues' do
        total_expenses = expenses_tr1.amount + expenses_tr2.amount
        total_revenues = revenues_tr1.amount + revenues_tr2.amount

        expect(ledger.totals).to eq [total_expenses, total_revenues]
      end
    end

    context 'balance' do
      it 'returns ledger balance' do
        total_expenses = expenses_tr1.amount + expenses_tr2.amount
        total_revenues = revenues_tr1.amount + revenues_tr2.amount
        calculated_balance = ledger.starting_balance + total_revenues - total_expenses

        expect(ledger.balance).to eq calculated_balance
      end
    end
  end
end
