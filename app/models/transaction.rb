class Transaction < ActiveRecord::Base
	belongs_to :ledger
end
