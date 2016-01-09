class Admin::UsersController < Admin::BaseController

  def index
    @team = Team.find(params[:team_id])
    @users = User.all
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to team_admin_users_path
  end

end
