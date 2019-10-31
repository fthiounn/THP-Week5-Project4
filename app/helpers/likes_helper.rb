module LikesHelper
  def nb_gossip_likes?(id)
    return Like.where(gossip_id: id).count
  end  
  def nb_comment_likes?(id)
    return Like.where(comment_id: id).count
  end
  def user_likes_gossip?(gossip_id)
    return false if Like.find_by(user_id: current_user.id, gossip_id: gossip_id).nil?
    return true
  end
  def user_likes_comment?(comment_id)
    return false if Like.find_by(user_id: current_user.id, comment_id: gossip_id).nil?
    return true
  end
end
