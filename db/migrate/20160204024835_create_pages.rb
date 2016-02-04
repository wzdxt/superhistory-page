class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      t.integer :status
      t.integer :content_version

      t.timestamps null: false
    end
  end
end
