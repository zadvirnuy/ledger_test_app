class Api::Ledgers::TagsController < Api::ApplicationController
	def create
		transaction = load_transaction
    byebug
   	# tag = Tag.new(source: transaction, name: params[:name])

    # if tag.save!
    #   render json: response_success(nil, tag: tag), status: 201
    # else
    #   render status: 422, json: response_fail('Unable to assign tag.', errors: tags.errors)
    # end
	end

	private

	def load_transaction
    Transaction.find params[:transaction_id]
  end
end
