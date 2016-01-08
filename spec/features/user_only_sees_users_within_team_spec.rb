require 'rails_helper'

RSpec.feature "User only sees users within team" do
  scenario "they are veiwing team dashboard." do
    team_1 = Team.create( name: "1510", password: "Turing" )
    team_2 = Team.create( name: "1511", password: "Turing" )

    user_1 = User.create(name: "Penney",
                         tagline: "foodie foodster",
                         gif_link: "tacos",
                         username: "PenPen",
                         password: "password",
                         password_confirmation: "password",
                         team_id: team_1.id)

    user_2 = User.create(name: "Jordan",
                         tagline: "wizard man",
                         gif_link: "pizza",
                         username: "JDog",
                         password: "password",
                         password_confirmation: "password",
                         team_id: team_2.id)

    visit "/teams/#{team_1.id}"

    expect(page).to have_content user_1.name
    expect(page).to_not have_content user_2.name
  end
end
