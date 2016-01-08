require 'rails_helper'

RSpec.feature "A user can logout" do
  scenario "they are back on the root login page" do
    team = Team.create(name: "1510",
                       password: "Turing",
                       password_confirmation: "Turing")

    user = User.create(name: "Penney",
                       tagline: "foodie foodster",
                       gif_link: "tacos",
                       username: "PenPen",
                       password: "password",
                       password_confirmation: "password",
                       team_id: team.id)

    visit team_path(team)
    click_on "Logout"

    expect(page).to_not have_content "Penney"
    #expect flash notice "Goodbye!"
    expect(current_path).to eq root_path
  end
end
