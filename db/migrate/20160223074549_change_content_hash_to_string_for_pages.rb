class ChangeContentHashToStringForPages < ActiveRecord::Migration
  def change
    change_column :pages, :content_hash, :string, :limit => 255
  end
end
