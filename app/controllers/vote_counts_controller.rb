class VoteCountsController < ApplicationController
  def dashboard
    @users = User.order('current_score DESC')
  end
  def graph
  end
  def update
    users = User.select('id, current_score').order('current_score DESC')
    hash = Hash[users.map {|user| [user.id, user.current_score]}]
    render json: hash
  end
end
