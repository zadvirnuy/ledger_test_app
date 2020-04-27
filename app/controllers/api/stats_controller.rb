class Api::StatsController < Api::ApplicationController
  def ledger_totals
    ledger = load_ledger
    expenses, revenues = ledger.totals(filter_params)

    render status: 200, json: response_success('Ledger Totals', expenses: expenses, revenues: revenues)
  end

  def ledger_balance
    ledger = load_ledger
    balance = ledger.balance

    render status: 200, json: response_success('Ledger Balance', balance: balance)
  end

  private

  def load_ledger
    Ledger.find(params[:ledger_id])
  end

  def filter_params
    tags = params[:tags].split(',').reject(&:blank?) if params[:tags]

    { year: params[:year], month: params[:month], tags: tags }
  end
end
