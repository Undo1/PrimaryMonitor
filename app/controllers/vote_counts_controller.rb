class VoteCountsController < ApplicationController
  def dashboard
    @users = User.order('current_score DESC')
  end
  def graph
    render layout: "graph"
  end
  def update
    users = User.select('id, current_score').order('current_score DESC')
    hash = Hash[users.map {|user| [user.id, user.current_score]}]
    render json: hash
  end
  def update_api
    users = User.select('link, current_score')
    hash = Hash[users.map {|user| [user.user_id, user.current_score]}]
    render json: hash
  end
end
