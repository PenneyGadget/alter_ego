require 'rails_helper'

RSpec.feature "User can vote for team mate" do
  scenario "they see the auction dashboard" do
    visit root_path
    click_on "Add New Team"
    expect(current_path).to eq new_team_path

    fill_in "Team Name", with: "1510"
    fill_in "Team Passcode", with: "Turing"
    fill_in "Team passcode confirmation", with: "Turing"
    click_on "Create Team"

    @team = Team.find_by(name: '1510')

    expect(current_path).to eq new_team_admin_path(@team)

    fill_in "Name", with: "Penney"
    fill_in "Tagline", with: "Rockstar cookie lover"
    fill_in "Word", with: "puppies" #this needs to generate a gif
    fill_in "Username", with: "penney_1"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"

    @auction = Auction.find_by(team_id: @team.id)

    User.create(name: 'Jordan',
                tagline: 'j',
                gif_link: 'lol',
                username: 'jordan',
                password: 'a',
                password_confirmation: 'a',
                team_id: @team.id)

    visit team_auction_path(@team, @auction)

    click_on "Vote for Jordan"

    @auction = Auction.find_by(team_id: @team.id)

    expect(current_path).to eq team_auction_path(@team, @auction)

    votes = eval(@auction.team_members_vote)

    expect(votes[:jordan]).to eq 1

  end
end
