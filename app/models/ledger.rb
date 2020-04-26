class Ledger < ActiveRecord::Base
	has_many :transactions

	validates_presence_of :name, :starting_balance
	validates_uniqueness_of :name
	validates :starting_balance, numericality: { only_float: true }

	def totals(filter_params = nil)
		expenses, revenues = total_expenses(filter_params), total_revenues(filter_params)
	end

	def balance
		self.starting_balance + total_revenues - total_expenses
	end

	private

	def total_expenses(filter_params = nil)
		expenses_tr = self.transactions.where(tr_type: 'expenses')
		expenses_tr = filter_transactions_by(expenses_tr, filter_params) if filter_params

		expenses_tr.map(&:amount).reduce(0, :+)
	end

	def total_revenues(filter_params = nil)
		revenues_tr = self.transactions.where(tr_type: 'revenues')
		revenues_tr = filter_transactions_by(revenues_tr, filter_params) if filter_params

		revenues_tr.map(&:amount).reduce(0, :+)
	end

	def filter_transactions_by(tr, filter_params)
		filtered = tr.where("CAST(strftime('%Y', date) as INT) = ?", filter_params[:year]) if filter_params[:year]
		filtered = tr.where("CAST(strftime('%m', date) as INT) = ?", filter_params[:month]) if filter_params[:month]

		filtered || tr
	end
end
