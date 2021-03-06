class Ledger < ActiveRecord::Base
  has_many :transactions
  has_many :tag_connections, as: :subject
  has_many :tags, through: :tag_connections

  validates_presence_of :name, :starting_balance
  validates_uniqueness_of :name
  validates :starting_balance, numericality: { only_float: true }

  def totals(filter_params = nil)
    expenses, revenues = total_expenses(filter_params), total_revenues(filter_params)
  end

  def balance
    self.starting_balance + total_revenues - total_expenses
  end

  def transactions_tag_filtered(tags:)
    tr_with_tags = Transaction.where(ledger_id: self.id)
    tr_with_tags.joins(:tags).where('lower("tags"."name") IN (?)', tags)
  end

  private

  def total_expenses(filter_params = nil)
    expenses_tr = Transaction.where(tr_type: 'expenses', ledger_id: self.id)
    expenses_tr = filter_transactions_by(expenses_tr, filter_params) if filter_params

    expenses_tr.map(&:amount).reduce(0, :+)
  end

  def total_revenues(filter_params = nil)
    revenues_tr = Transaction.where(tr_type: 'revenues', ledger_id: self.id)
    revenues_tr = filter_transactions_by(revenues_tr, filter_params) if filter_params

    revenues_tr.map(&:amount).reduce(0, :+)
  end

  def filter_transactions_by(tr, filter_params)
    filtered = tr.where("CAST(strftime('%Y', date) as INT) = ?", filter_params[:year]) if filter_params[:year]
    filtered = tr.where("CAST(strftime('%m', date) as INT) = ?", filter_params[:month]) if filter_params[:month]
    filtered = tr.joins(:tags).where('lower("tags"."name") IN (?)', filter_params[:tags]) if filter_params[:tags]

    filtered.try(:uniq) || tr.try(:uniq)
  end
end
