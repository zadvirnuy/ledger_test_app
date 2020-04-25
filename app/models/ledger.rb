class Ledger < ActiveRecord::Base
  has_many :transactions
end
