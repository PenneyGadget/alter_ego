require 'rails_helper'

RSpec.feature "Admin can declare winner for auction" do
  scenario "they see the auction dashboard" do

    @team = Team.create(name: "1510", password: "password", password_confirmation: "password")

    visit new_team_admin_path(@team)

    fill_in "Name", with: "Penney"
    fill_in "Tagline", with: "Rockstar cookie lover"
    fill_in "Word", with: "puppies" #this needs to generate a gif
    fill_in "Username", with: "penney_1"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"

   @admin = User.find_by(username: 'penney_1')

   @auction = Auction.find_by(team_id: @team.id)

   @user = User.create(name: "Jordan",
                        tagline: "foodie foodster",
                        gif_link: "taco",
                        username: "jordan",
                        password: "password",
                        password_confirmation: "password",
                        team_id: @team.id)

    ApplicationController.any_instance.stub(:current_user).and_return(@admin)

    visit team_auction_path(@team, @auction)

    click_on "Vote for Jordan"

    expect(current_path).to eq team_auction_path(@team, @auction)

    click_on "Declare Winner"

    @user_updated = User.find_by(username: @user.username)

    expect(current_path).to eq team_auction_path(@team, (@auction.id + 1))

    expect(page).to have_content "Winner of previous round: Jordan"

    expect(@user_updated.gif_link).to eq @auction.gif_link
  end
end
