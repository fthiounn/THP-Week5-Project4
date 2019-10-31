class LikesController < ApplicationController
  before_action :find_like_type
  def create
    if @type_is_comment
      #on traite un like de commentaire
      Like.create(user: current_user, comment_id: params[:comment_id])
    else
      #on traite un like de gossip
      Like.create(user: current_user,gossip_id: params[:gossip_id])
    end
    flash[:success] = "Liked !"
    redirect_to :controller => 'gossips', :action => 'show', :id => params[:id]
  end

  def destroy
    Like.destroy(@like.id)
    flash[:success] = "Unliked !"
    redirect_to :controller => 'gossips', :action => 'show', :id => params[:gossip_id]

  end
  def find_like_type
    if !params[:comment_id].nil?
      #on traite un like de commentaire
      #pour le destroy
      @like = Like.find_by(comment_id: params[:comment_id]) if !params[:comment_id].nil?
      @type_is_comment = true
    else
      #on traite un like de gossip
      #pour le destroy
      @like = Like.find_by(gossip_id: params[:id]) if !params[:id].nil?
      @type_is_comment = false
    end
  end
end
