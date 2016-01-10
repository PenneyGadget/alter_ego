class AuctionController < ApplicationController

  def create
    @team = Team.find(team_hash)
    @auction = Auction.create(team)
  end

  def update_votes
    @auction = Auction.find(params[:id])

    @auction.update(update_votes)
  end

  def declare_winner
    @auction = Auction.find(params[:id])

    @auction.update(winner)
  end

  private

  def set_team
    team_hash = {team_name: team.name,
                 team_members_vote: create_team_hash,
                 gif_link: Giphy.random.image_original_url.to_s,
                 winner: "pending"}
  end

  def update_team
    team_hash = {team_name: team.name,
                 team_members_vote: update_votes,
                 gif_link: Giphy.random.image_original_url.to_s,
                 winner: winner}
  end

  def create_team_hash
    Auction.create_team_hash(@team)
  end

  def update_votes
    votes = @auction.team_members_vote
    Auction.vote_cast(votes, params[:username])
  end

  def winner
    votes = @auction.team_members_vote
    Auction.winner(votes)
  end

end
