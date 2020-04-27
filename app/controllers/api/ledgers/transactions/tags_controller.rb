class Api::Ledgers::Transactions::TagsController < Api::ApplicationController
	def create
		transaction = load_transaction
   	
   	tag = ::TagsService.new(name: params[:name], source: transaction).execute

    if tag
      render json: response_success(nil, tag: tag.name), status: 201
    else
      render status: 422, json: response_fail('Unable to assign tag.', errors: tag.errors)
    end
	end

	private

	def load_transaction
    Transaction.find params[:transaction_id]
  end
end
