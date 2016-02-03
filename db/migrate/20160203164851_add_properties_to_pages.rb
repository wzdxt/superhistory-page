class AddPropertiesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :status, :integer
    add_column :pages, :content_version, :integer
    add_column :pages, :original_content, :text
  end
end
