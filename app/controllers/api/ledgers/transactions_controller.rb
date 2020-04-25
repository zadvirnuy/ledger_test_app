class Api::Ledgers::TransactionsController < Api::ApplicationController
	def index
		transactions = public_ledgers_transactions
		
		render json: response_success(nil, transactions: transactions.as_json)
	end

	def create
		transaction = Transaction.new(transaction_params)

		if transaction.save
			render status: 201, json: response_success
		else
			render status: 422, json: response_fail('Unable to create Transaction', errors: transaction.errors.full_messages.join(', '))
		end
	end

	def update
		transaction = load_transaction
		
		if transaction.update_attributes(transaction_params)
			render status: 200, json: response_success('Transaction updated', transaction: transaction)
		else
			render status: 422, json: response_fail('Unable to create Transaction', errors: transaction.errors.full_messages.join(', '))
		end 
	end

	private

	def public_ledgers_transactions
		load_ledger.transactions
	end

	def load_ledger
		Ledger.find(params[:ledger_id])
	end

	def load_transaction
		Transaction.find(params[:id])
	end

	def transaction_params
		params.permit(:ledger_id, :amount, :date, :tr_type, :description)
	end
end