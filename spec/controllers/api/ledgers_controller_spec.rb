require 'rails_helper'

describe Api::LedgersController, type: :controller do
	context '#index' do
		let!(:ledgers) { create_list(:ledger, 4) }

		it 'returns list of all ledgers' do
			get :index, format: :json

			expect(response).to be_successful
			expect(parse_json(response.body).keys).to contain_exactly('success', 'alert', 'ledgers')
			expect(parse_json(response.body, 'ledgers')).to match_array(ledgers.as_json)
		end
	end

	context '#show' do
		let!(:ledger) { create(:ledger, id: 33) }

		context 'success' do
			it 'returns ledger' do
				get :show, params: { id: 33 }
				
				expect(response).to be_successful
				expect(parse_json(response.body, 'ledger')).to match_array(ledger.as_json)
			end
		end

		context 'failure' do
			it 'returns not found response' do
				get :show, params: { id: 3 }

				expect(response.status).to eq 404
			end
		end
	end

	context '#create' do
		context 'success' do
			it 'creates ledger' do
				post :create, params: { name: 'Test Create', starting_balance: 100 }

				expect(response).to have_http_status(:created)
				expect(Ledger.last.name).to eq 'Test Create'
			end
		end

		context 'failure' do
			let!(:ledger) { create(:ledger, name: 'Test1') }

			it 'response with error message' do
				post :create, params: { name: 'Test1', starting_balance: '100bbb' }

				expect(response.status).to eq 422
				expect(parse_json(response.body, 'alert')).to eq "Unable to create Ledger"
				expect(parse_json(response.body, 'errors')).to eq "Name has already been taken, Starting balance is not a number"
			end
		end
	end

	context '#update' do
		let!(:ledger1) { create(:ledger, id: 33, name: 'Pens') }
		let!(:ledger2) { create(:ledger, id: 34, name: 'Pensils') }

		context 'success' do
			it 'updates ledger' do
				patch :update, params: { name: 'Staplers', id: 33 }

				expect(response).to have_http_status(:success)
				expect(ledger1.reload.name).to eq 'Staplers'
				expect(parse_json(response.body, 'ledger')).to match_array(ledger1.reload.as_json)
			end
		end

		context 'failure' do
			it 'response with error message' do
				patch :update, params: { name: 'Pens', id: 34, starting_balance: '100bbb' }

				expect(response.status).to eq 422
				expect(parse_json(response.body, 'alert')).to eq "Unable to update Ledger"
				expect(parse_json(response.body, 'errors')).to eq "Name has already been taken, Starting balance is not a number"
			end
		end
	end
end
