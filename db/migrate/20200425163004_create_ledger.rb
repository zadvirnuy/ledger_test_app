class CreateLedger < ActiveRecord::Migration[6.0]
  def change
    create_table :ledgers do |t|
    	t.string :name, null: false
    	t.float  :starting_balance, null: false, default: 0

      t.timestamps
    end
  end
end
