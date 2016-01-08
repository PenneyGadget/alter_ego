require 'rails_helper'

RSpec.feature "A registered user can login" do
  scenario "they see the team dashboard page" do
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

    visit root_path
    click_on "Login to Your Team"

    expect(current_path).to eq login_path

    fill_in "Username", with: "PenPen"
    fill_in "Password", with: "password"
    click_on "Login"

    expect(current_path).to eq team_path(team)

    #expect flash notice
    expect(page).to have_content "Team: 1510"
    expect(page).to have_content "Penney"
    #expect to have gif/image/css
  end
end
