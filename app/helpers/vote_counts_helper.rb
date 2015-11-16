module VoteCountsHelper
  require 'open-uri'
  require "activerecord-import/base"
  ActiveRecord::Import.require_adapter('sqlite')

  def self.fetch_votes
    doc = Nokogiri::HTML(open('http://stackoverflow.com/election/6?tab=primary&purpose=undosprimarymonitor'))

    vote_counts = []

    doc.css(".vote-count-post").each do |vote_count|
      puts score = vote_count.content

      nomination_post = vote_count.parent.parent.parent.parent

      username_link = nomination_post.css(".user-details a").first
      username = username_link.content
      user_link = username_link["href"]

      user = User.find_or_create_by(link: user_link)
      user.display_name = username
      user.current_score = score

      changed = user.changed? or user.new_record?

      if changed
        user.save!
        vote_counts << VoteCount.new(:user_id => user.id, :score => score)
      end
    end
    VoteCount.import vote_counts
  end
end
