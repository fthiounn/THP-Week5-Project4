class CommentsController < ApplicationController
  def show
  end

  def new
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
  end

  def create
    @comment = Comment.new('content' => params[:content],user: User.find(1), gossip: Gossip.find(params[:gossip_id]))
    if @comment.save
        flash[:success] = "You successfuly created a comment"
        redirect_to :controller => 'gossips', :action => 'show', notice: 'Success', :id => params[:gossip_id]
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash.now[:danger] = "Error with the comment creation"
      redirect_to :action => 'new'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    comment_param = params.require(:comment).permit(:content)
    if @comment.update(comment_param)
        flash[:success] = "You successfuly updated a comment"
      redirect_to :controller => 'gossips',action: 'show', notice: 'Success', :id => params[:gossip_id]
    else
      flash.now[:danger] = "Error with the comment update"
      redirect_to :action => 'edit'
    end
  end

  def destroy
    if Comment.destroy(params[:comment_id])
      flash[:success] = "You successfuly deleted a comment"
      redirect_to :controller => 'gossips', action: "show", notice: 'Success with deletion', :id => params[:id]
    else
      flash.now[:danger] = "Error with the comment deletion"
      redirect_to action: "show", notice: 'Faillure with deletion', :id => params[:id]
    end
  end
end
