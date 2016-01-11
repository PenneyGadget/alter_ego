class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.name}"
      auction = Auction.where(team_id: user.team_id).last
      redirect_to team_auction_path(user.team_id, auction)
    else
      flash[:notice] = "Username could not be found or password incorrect"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end
