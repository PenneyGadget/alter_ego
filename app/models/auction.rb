class Auction < ActiveRecord::Base

  belongs_to :teams

  attr_reader :votes

  def self.create_team_hash(team)
    votes = {}
    team.each do |member|
      votes[member.username.to_sym] = 0
    end
    votes
  end

  def self.update_team_hash(team, votes)
    votes = eval(votes)
    team.each do |member|
      votes[member.username.to_sym] = 0 if !votes[member.username.to_sym]
    end
    votes
  end

  def self.vote_cast(votes, username)
    votes[username.to_sym] += 1
    votes
  end

  def self.winner(votes)
    votes = eval(votes)
    votes.sort_by { |username, votes| votes }.last
  end

end
