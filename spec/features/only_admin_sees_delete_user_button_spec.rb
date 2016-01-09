require 'rails_helper'

RSpec.feature "Admin can delete user, when veiwing user index" do
  scenario "user is no longer on page" do


    team = Team.create(name: 1510, password: "Turing")

    user = User.create(name: "Penney",
                       tagline: "foodie foodster",
                       gif_link: "tacos",
                       username: "PenPen",
                       password: "password",
                       password_confirmation: "password",
                       role: 1,
                       team_id: team.id)

     user_2 = User.create(name: "Jordan",
                        tagline: "I like turtles",
                        gif_link: "ginger",
                        username: "jlawlz",
                        password: "password",
                        password_confirmation: "password",
                        team_id: team.id)

    # allow(ApplicationController).to receive(:current_user).and_return(user)
    ApplicationController.any_instance.stub(:current_user).and_return(user)

    visit team_admin_users_path(team)

    within('li:last') do
      click_on "Delete User"
    end

    expect(current_path).to eq team_admin_users_path(team)

    expect(page).to have_content "1510"
    expect(page).to have_content "Penney"
    expect(page).to_not have_content "Jordan"

  end
end
