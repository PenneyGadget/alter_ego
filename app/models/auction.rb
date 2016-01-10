class Auction < ActiveRecord::Base

  attr_reader :votes

  def self.create_team_hash(team)
    @votes = team.map do |t|
      votes[t.username.to_s] = 0
    end
  end

  def self.vote_cast(votes, username)
    votes[username.to_s] += 1
    votes
  end

  def self.winner(votes)
    votes.sort_by { |username, votes| votes }.last
  end

end
