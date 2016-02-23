class AddHttpStatusToPages < ActiveRecord::Migration
  def change
    add_column :pages, :http_status, :integer
  end
end
