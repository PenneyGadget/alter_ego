class AddGifLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gif_link, :string
  end
end
