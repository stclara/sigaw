class CreateHistoricalCashes < ActiveRecord::Migration
  def change
    create_table :historical_cashes do |t|
      t.string :description, :limit => 200
      t.timestamps
    end
  end
end
