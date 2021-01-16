class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.string :description
      t.decimal :amount, precision: 8, scale: 2
      t.string :status
      t.boolean :confirm
      t.references :user, null: false, foreign_key: true
      t.references :wallet, null: true, foreign_key: true
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
