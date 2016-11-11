module VoteCountsHelper
  require 'open-uri'
  require "activerecord-import/base"
  ActiveRecord::Import.require_adapter('sqlite')

  def self.run_cycle
    12.times do
      result = VoteCountsHelper.fetch_votes
      break if !result
      sleep 5
    end
  end

  def self.fetch_votes
    url = 'http://stackoverflow.com/election/7?tab=primary&purpose=undosprimarymonitor'

    begin
      file = open(url)
      doc = Nokogiri::HTML(file)

      vote_counts = []

      doc.css(".vote-count-post").each do |vote_count|
        nomination_post = vote_count.parent.parent.parent.parent

        username_link = nomination_post.css(".user-details a").first
        username = username_link.content
        user_link = username_link["href"]

        user = User.find_or_create_by(link: user_link)
        user.display_name = username
        user.current_score += rand(1..30)

        changed = user.changed? or user.new_record?

        if changed
          user.save!
          vote_counts << VoteCount.new(:user_id => user.id, :score => user.current_score)
        end
      end
      VoteCount.import vote_counts

      ActionCable.server.broadcast "vote_counts", vote_counts.map {|n| [n.user_id.to_s, n.score] }.to_h if vote_counts.present?

      return true

    rescue OpenURI::HTTPError => e
      return false
    end
  end
end
