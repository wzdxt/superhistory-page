class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url, :limit => 1000
      t.integer :target_page_id
      t.integer :status
      t.integer :content_hash, :limit => 8, :index => true
      t.integer :content_version

      t.timestamps null: false
    end
  end
end
