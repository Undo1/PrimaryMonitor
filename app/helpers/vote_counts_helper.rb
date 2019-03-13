module VoteCountsHelper
  require 'open-uri'
  require "activerecord-import/base"
  ActiveRecord::Import.require_adapter('sqlite')

  def self.run_cycle
    2.times do
      result = VoteCountsHelper.fetch_votes
      break if !result
      sleep 30
    end
  end

  def self.fetch_votes
    if Time.now.utc < "2019-3-11 20:00:00Z".to_time
      Rails.logger.info "Primary hasn't started yet. #{Time.now.utc} < '2019-3-11 20:00:00 UTC'"
      return true
    end

    url = 'http://stackoverflow.com/election/11?tab=primary&purpose=undosprimarymonitor'

    begin
      file = open(url)
      doc = Nokogiri::HTML(file)

      vote_counts = []

      doc.css(".js-vote-count").each do |vote_count|
        nomination_post = vote_count.parent.parent.parent

        username_link = nomination_post.css(".user-details a").first
        username = username_link.content
        user_link = username_link["href"]

        user = User.find_or_create_by(link: user_link)
        user.display_name = username
        user.current_score = vote_count.content

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
