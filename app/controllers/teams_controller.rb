class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    if @team.save
      redirect_to new_team_admin_path(@team)
    else
      flash[:error] = "Team name is already taken"
      redirect_to new_team_path
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def find
  end

  def find_to_user
    @team = Team.find_by(name: params[:find_team][:team])
    redirect_to new_team_user_path(@team)
  end

  private

  def team_params
    params.require(:team).permit(:name, :password, :password_confirmation)
  end

end
