class Transaction < ActiveRecord::Base
	VALID_TYPES = %w(expenses revenues).freeze

	belongs_to :ledger

	validates_presence_of :ledger_id, :amount, :date, :tr_type
	validates :amount, numericality: { only_float: true }
	validates_format_of :date, :with => /\d{4}\-\d{2}\-\d{2}/, message: "Date must be in the following format: yyyy-mm-dd"
	validates_inclusion_of :tr_type, :in => VALID_TYPES
	
end
