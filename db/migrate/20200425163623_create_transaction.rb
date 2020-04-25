class CreateTransaction < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
    	t.references :ledger, foreign_key: true, null: false
    	t.float :amount, null: false, default: 0
    	t.datetime :date
    	t.string :tr_type, null: false
    	t.text :description

    	t.timestamps
    end
  end
end
