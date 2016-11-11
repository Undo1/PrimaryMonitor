# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class VoteCountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "vote_counts"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update
  end
end
