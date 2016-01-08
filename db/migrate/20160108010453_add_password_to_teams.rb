class AddPasswordToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :password_digest, :string
  end
end
