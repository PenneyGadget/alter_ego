require 'rails_helper'

RSpec.feature "User can create an account" do
  scenario "they see the team dashboard" do

    Team.create(name: 1510, password: "Turing")

    visit root_path

    click_on "Join a Team"

    expect(current_path).to eq teams_find_path

    fill_in "Team Name", with: "1510"
    fill_in "Team Passcode", with: "Turing"
    click_on "Join Team"

    @team = Team.find_by(name: 1510)

    expect(current_path).to eq new_team_user_path(@team)

    fill_in "Name", with: "Penney"
    fill_in "Tagline", with: "Rockstar cookie lover"
    fill_in "Word", with: "puppies" #this needs to generate a gif
    fill_in "Username", with: "penney_1"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"
    expect(current_path).to eq team_path(@team)

    expect(page).to have_content "1510"
    expect(page).to have_content "Penney"
    #expect page to have image
  end
end
