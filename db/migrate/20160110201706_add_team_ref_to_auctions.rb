class AddTeamRefToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :team, index: true, foreign_key: true
  end
end
