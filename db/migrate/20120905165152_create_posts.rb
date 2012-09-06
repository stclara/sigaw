class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :visible, :limit => 3
      t.string :title, :limit => 200
      t.string :photo_file_name, :photo_content_type
      t.integer :photo_file_size
      t.timestamps
    end
  end
end
