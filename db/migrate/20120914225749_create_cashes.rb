class CreateCashes < ActiveRecord::Migration
  def change
    create_table :cashes do |t|
      t.references :historical_cash
      t.date :date_cash
      t.decimal :value_cash, :precision => 8, :scale => 2, :default => 0.0
      t.string :description, :limit => 200
      t.string :type_cash, :type_payment, :limit => 1
      t.timestamps
    end
  end
end
