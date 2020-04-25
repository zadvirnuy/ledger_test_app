class Api::LedgersController < Api::ApplicationController
	def index
		ledgers = public_ledgers_collection
		
		render json: response_success(nil, ledgers: ledgers.as_json)
	end

	def show
		ledger = load_ledger

		render json: response_success(nil, ledger: ledger.as_json)
	end

	def create
		ledger = Ledger.new(ledger_params)

		if ledger.save
			render status: 201, json: response_success
		else
			render status: 422, json: response_fail('Unable to create Ledger', errors: ledger.errors.full_messages.join(', '))
		end
	end

	def update
		ledger = load_ledger
		
		if ledger.update_attributes(ledger_params)
			render status: 200, json: response_success('Ledger updated', ledger: ledger)
		else
			render status: 422, json: response_fail('Unable to create Ledger', errors: ledger.errors.full_messages.join(', '))
		end 
	end

	private

	def load_ledger
		Ledger.find(params[:id])
	end

	def public_ledgers_collection
		Ledger.all
	end

	def ledger_params
		params.permit(:name, :starting_balance)
	end
end
