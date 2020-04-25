class Ledger < ActiveRecord::Base
  has_many :transactions

  validates_presence_of :name, :starting_balance
  validates_uniqueness_of :name
  validates :starting_balance, numericality: { only_float: true }
end
