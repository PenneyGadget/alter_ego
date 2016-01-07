require 'rails_helper'

RSpec.feature "User only sees users within team" do
  scenario "they are veiwing team dashboard." do

    team_1 = Team.create( name: "1510" )
    team_2 = Team.create( name: "1511" )
    
    user_1 = User.create(name: "1 User", team_id: team_1.id)
    user_2 = User.create(name: "2 User", team_id: team_1.id)
    user_3 = User.create(name: "3 User", team_id: team_2.id)

    visit "/teams/#{team_1.id}"

    save_and_open_page

    expect(page).to have_content user_1.name
    expect(page).to have_content user_2.name
    expect(page).to_not have_content user_3.name

  end
end
