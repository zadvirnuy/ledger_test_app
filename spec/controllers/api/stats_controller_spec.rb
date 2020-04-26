require 'rails_helper'

describe Api::StatsController, type: :controller do
  let!(:ledger) { create(:ledger) }

  context '#ledger_totals' do
    it 'response with ledger totals' do
      get :ledger_totals, params: { ledger_id: ledger.id }

      expect(response).to have_http_status(:success)
      expect(parse_json(response.body, 'expenses')).to eq ledger.totals[0]
      expect(parse_json(response.body, 'revenues')).to eq ledger.totals[1]
    end
  end

  context '#ledger_balance' do
    it 'response with ledger balance' do
      get :ledger_balance, params: { ledger_id: ledger.id }

      expect(response).to have_http_status(:success)
      expect(parse_json(response.body, 'balance')).to eq ledger.balance
    end
  end
end
