require 'rails_helper'

describe Api::Ledgers::TransactionsController, type: :controller do
	let!(:ledger) { create(:ledger, id: 33) }
	let!(:ledger2) { create(:ledger, id: 34) }
	let!(:expenses_tr1) { create(:expenses_transaction, ledger: ledger) }
	let!(:revenues_tr1) { create(:revenues_transaction, ledger: ledger) }
	let!(:expenses_tr2) { create(:expenses_transaction, ledger: ledger2) }
	let!(:revenues_tr2) { create(:revenues_transaction, ledger: ledger2) }

	context '#index' do
		it 'returns list of only requested ledger transaction' do
			get :index, params: { ledger_id: 33 }

			expect(response).to be_successful
			expect(parse_json(response.body).keys).to contain_exactly('success', 'alert', 'transactions')
			expect(parse_json(response.body, 'transactions')).to match_array([expenses_tr1.as_json, revenues_tr1.as_json])
		end
	end

	context '#create' do
		context 'success' do
			it 'creates ledger transaction' do
				expect(ledger.transactions.count).to eq 2

				post :create, params: { ledger_id: 33, amount: 100, date: '2020-04-25', tr_type: 'revenues', description: 'Pens' }

				expect(response).to have_http_status(:created)
				expect(ledger.transactions.count).to eq 3
				expect(ledger.transactions.last.description).to eq 'Pens'
			end
		end

		context 'failure' do
			it 'response with error message' do
				post :create, params: { ledger_id: 133, amount: '100sds', date: '2020-043-25', tr_type: 'test', description: 'Pens' }

				expect(response.status).to eq 422
				expect(parse_json(response.body, 'alert')).to eq "Unable to create Transaction"
				expect(parse_json(response.body, 'errors')).to eq "Ledger must exist, Date can't be blank, Date Date must be in the following "\
																													"format: yyyy-mm-dd, Amount is not a number, Tr type is not included in the list"
			end
		end
	end

	context '#update' do
		context 'success' do
			it 'updates ledger transaction' do
				patch :update, params: { ledger_id: 33, tr_type: 'revenues', id: expenses_tr1.id, description: 'Staplers' }

				expect(response).to have_http_status(:success)
				expect(expenses_tr1.reload.description).to eq 'Staplers'
				expect(expenses_tr1.reload.tr_type).to eq 'revenues'
				expect(parse_json(response.body, 'transaction')).to match_array(expenses_tr1.reload.as_json)
			end
		end

		context 'failure' do
			it 'response with error message' do
				patch :update, params: { ledger_id: 33, tr_type: 'test', id: expenses_tr1.id, amount: '100bbb' }

				expect(response.status).to eq 422
				expect(parse_json(response.body, 'alert')).to eq "Unable to update Transaction"
				expect(parse_json(response.body, 'errors')).to eq "Amount is not a number, Tr type is not included in the list"
			end
		end
	end
end
