class AdminsController < ApplicationController

  def new
    @admin = User.new
  end

  def create
    @team = Team.find(params[:team_id])
    @admin = User.create(admin_params)
    if @admin.save
      redirect_to team_path(@team)
    elsif User.find_by(username: params[:user][:username])
      flash[:error] = "Username is already taken"
      redirect_to new_team_admin_path(@team)
    elsif missing_param?
      flash[:error] = "Field is missing. All fields required"
      redirect_to new_team_admin_path(@team)
    end
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
    admin_hash[:gif_link] = Giphy.random(params[:user][:gif_link]).image_original_url.to_s
    admin_hash
  end

  def missing_param?
    admin_params
  end


end
