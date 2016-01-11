require 'rails_helper'

RSpec.feature "User can create an account" do
  scenario "they see the team dashboard" do

    @team = Team.create(name: '1510', password: 'password', password_confirmation: 'password')

    visit new_team_admin_path(@team)

    fill_in "Name", with: "Jordan"
    fill_in "Tagline", with: "lol"
    fill_in "Word", with: "kittens" #this needs to generate a gif
    fill_in "Username", with: "jordan_1"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"

    visit root_path

    click_on "Join a Team"

    expect(current_path).to eq teams_find_path

    fill_in "Team Name", with: "1510"
    fill_in "Team Passcode", with: "password"
    click_on "Join Team"

    expect(current_path).to eq new_team_user_path(@team)

    fill_in "Name", with: "Penney"
    fill_in "Tagline", with: "Rockstar cookie lover"
    fill_in "Word", with: "puppies" #this needs to generate a gif
    fill_in "Username", with: "penney_1"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"

    @auction = Auction.find_by(team_id: @team.id)

    expect(current_path).to eq team_auction_path(@team, @auction)

    expect(page).to have_content "1510"
    expect(page).to have_content "Penney"
    #expect page to have image

  end
end
