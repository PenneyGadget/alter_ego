class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    redirect_to new_team_admin_path(@team)
  end

  private

  def team_params
    params.require(:team).permit(:name, :password, :password_confirmation)
  end

end
