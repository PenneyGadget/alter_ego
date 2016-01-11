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
    @auction = Auction.find_by(team_id: @team.id)
    if @user.save
      redirect_to team_auction_path(@team, @auction)
    elsif User.find_by(username: params[:user][:username])
      flash[:error] = "Username is already taken"
      redirect_to new_team_user_path(@team)
    elsif missing_param?
      flash[:error] = "Field is missing. All fields required"
      redirect_to new_team_user_path(@team)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to team_admin_users_path
  end

  def update_user_gif
    @user = User.find(params[:user_id])
    @auction = Auction.find(params[:auction][:auction_id])
    @auction.update(user_id: @user.id)
    @team = Team.find(params[:team_id])
    @user.update(assign_gif)

    flash[:notice] = "Winner of previous round: #{@user.name}"

    redirect_to new_team_auction_path(@team)
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
    user_hash[:gif_link] = Giphy.random(params[:user][:gif_link]).image_original_url.to_s
    user_hash
  end

  def missing_param?
    user_params
  end

  def assign_gif
    {gif_link: @auction.gif_link}
  end

end
