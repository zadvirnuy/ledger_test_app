Task description: 

We want to build a ledger application to track transactions into and out of our government. We
need an API where users can create ledgers and then add expense and revenue transactions to
those ledgers. A ledger has the following attributes:
- name
- starting balance
The starting balance is simply how much money the ledger has at the beginning.
A ledger has a set of transactions where each transaction has the following attributes:
- ledger id
- amount
- date
- type (either 'expense' or 'revenue')
- description (optional)
Of course, revenue is money the government is bringing in and expense is money the
government is spending. An example of a revenue transaction would be: we received $38.01 on
2020-01-26 in parking meter fees. An example of an expense transaction would be: we spent
$24.20 on 2020-02-15 to purchase staplers.
Finally, I should be able to list my transactions for a given ledger, see my total expenses and
revenues aggregated by month, and also see my current balance. Current balance = starting
balance + total revenues - total expenses, for all time.


-------------------------------------------------------------------------------------------------------------

Assumptions Explanation:
Assumptions were made that information is public, and no security, authentication, or authorization was made. 
Due to that assumption endpoints for Delete action were not added. 


-------------------------------------------------------------------------------------------------------------

API Endpoinds descriptions: 

 POST   /api/ledgers/:ledger_id/transactions/:transaction_id/tags 
 		creates tags on transaction
 		Parameters: 
 			required:
 				name: string

 GET    /api/ledgers/:ledger_id/transactions
 		collection of ledger transactions

 POST   /api/ledgers/:ledger_id/transactions
 		creates transaction for ledger
 		Parameter:
 			required: 
	 			amount: float
	 			date: string value in 'yyyy-mm-dd' format
	 			tr_type: type of transaction , accepting values are 'expenses' or 'revenues' . (Field was named tr_type not type because type is reserved name in Rails)
 			optional:
 				description: text field

 PATCH  /api/ledgers/:ledger_id/transactions/:id
 		updates existing transaction
 		Parameter:
 			required: 
	 			amount: float
	 			date: string value in 'yyyy-mm-dd' format
	 			tr_type: type of transaction , accepting values are 'expenses' or 'revenues' . (Field was named tr_type not type because type is reserved name in Rails)
 			optional:
 				description: text field

 GET    /api/ledgers
 		collection of ledgers

 POST   /api/ledgers
 		creates ledger
 		Parameter:
 			required: 
 				name: string, should be unique
	 			amount: starting_balance

 GET    /api/ledgers/:id
 		show ledger

 PATCH  /api/ledgers/:id
	  updates ledger
	 		Parameter:
	 			required: 
	 				name: string, should be unique
		 			amount: starting_balance

 GET    /api/stats/ledger_totals
 		shows information about lendger expenses and revenues, filtration can be used by year, month and tag/tags
 			Parameter:
	 			optional: 
	 				year: format 'yyyy'
		 			month: format 'mm'
		 			tags: string, format( 'first tag' or comma separated 'first tag, second tag' )

 GET    /api/stats/ledger_balance
 		shows ledger balance 


-------------------------------------------------------------------------------------------------------------

Code Structure:

