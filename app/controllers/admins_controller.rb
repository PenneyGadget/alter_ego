class AdminsController < ApplicationController

  def new
    @admin = User.new
  end

  def create
    @team = Team.find(params[:team_id])
    @admin = User.create(admin_params)

    redirect_to team_path(@team)
  end

  private

  def admin_params
    admin_hash = params.require(:user).permit(:name,
                                               :tagline,
                                               :gif_link,
                                               :username,
                                               :password,
                                               :password_confirmation)
    admin_hash[:role] = 1
    admin_hash[:team_id] = @team.id
    admin_hash
  end

end
