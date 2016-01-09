class UsersController < ApplicationController

  def index
    @team = Team.find(params[:team_id])
    @users = User.all
  end

  def new
    @team = Team.find(params[:team_id])
    @user = User.new
  end

  def create
    @team = Team.find(params[:team_id])
    @user = User.create(user_params)
    redirect_to team_path(params[:team_id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to team_admin_users_path
  end

  private

  def user_params
    user_hash = params.require(:user).permit(:name,
                                             :team_id,
                                             :tagline,
                                             :gif_link,
                                             :username,
                                             :password,
                                             :password_confirmation)
    user_hash[:team_id] = @team.id
    user_hash
  end

end
