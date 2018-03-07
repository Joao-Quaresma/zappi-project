
module SocialpostsHelper
  def display_likes(socialpost)
    votes = socialpost.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 20
    count_likers(votes)
  end

  def liked_socialpost(socialpost)
    return 'glyphicon-heart' if current_user.voted_for? socialpost
    'glyphicon-heart-empty'
  end

  private

  def list_likers(votes)
    usernames = []
    unless votes.blank?
      votes.voters.each do |voter|
        usernames.push(link_to voter.username,
                                user_path(voter.id),
                                class: 'user-name')
      end
      usernames.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end