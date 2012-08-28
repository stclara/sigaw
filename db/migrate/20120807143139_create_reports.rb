class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :relatorio, :arquivo, :email, :limit => 200
      t.string :caminho, :limit => 300
      t.timestamps
    end
  end
end
