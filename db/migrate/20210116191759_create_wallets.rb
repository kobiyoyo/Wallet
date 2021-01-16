class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.decimal :amount, precision: 8, scale: 2,default: 0
      t.boolean :main
      t.references :user, foreign_key: true,  null: false
      t.references :currency, foreign_key: true,  null: false

      t.timestamps
    end
  end
end
