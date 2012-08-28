class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :mail,                             :limit => 100
      t.string :password_hash, :password_salt,           :limit => 300
      t.string :adm, :ger, :opr, :est, :cxa, :pag, :rec, :limit => 3
      t.timestamps
    end
  end
end
