class AuctionsController < ApplicationController

  def new
    @auction = Auction.new
    create_auction
  end

  def create_auction
    @team = Team.find(params[:team_id])
    @auction = Auction.create(set_auction)
    redirect_to team_auction_path(@team, @auction)
  end

  def show
    @team = Team.find(params[:team_id])
    @auction = Auction.all.last
    @user = User.find_by(username: winner[:winner])
    @admin = current_admin?
  end

  def update_votes
    @team = Team.find(params[:team_id])
    @auction = Auction.find(params[:auction_id])
    @auction.update(update_auction)

    redirect_to team_auction_path(@team, @auction)
  end

  def declare_winner
    @auction = Auction.find(params[:auction_id])
    @team = Team.find(params[:team_id])
    @auction.update(winner)
    @user = User.find_by(username: winner[:winner])

    redirect_to team_auction_user_update_user_gif_path(@team, @auction, @user)
  end

  private

  def set_auction
    team_hash = {team_name: @team.name,
                 team_members_vote: create_team_hash,
                 gif_link: Giphy.random.image_original_url.to_s,
                 winner: "pending",
                 team_id: params[:team_id],
                 }
  end

  def update_auction
    { team_members_vote: update_vote }
  end

  def create_team_hash
    Auction.create_team_hash(@team.users.all)
  end

  def update_team_hash
    Auction.update_team_hash(@team.users.all, @auction.team_members_vote)
  end

  def update_vote
    Auction.vote_cast(update_team_hash, params[:auction][:username])
  end

  def winner
    votes = @auction.team_members_vote
    { winner: Auction.winner(votes)[0].to_s }
  end

end
