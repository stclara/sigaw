class CreateDateCashes < ActiveRecord::Migration
  def change
    create_table :date_cashes do |t|
      t.date :date_cash
      t.timestamps
    end
  end
end
