class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :team_name
      t.string :team_members_vote
      t.string :gif_link
      t.string :winner

      t.timestamps null: false
    end
  end
end
