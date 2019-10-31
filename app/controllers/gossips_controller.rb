class GossipsController < ApplicationController
  def index
    @gossip_array = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = Comment.where(gossip_id: params[:id]).all
  end

  def new
    @tag = Tag.all
  end

  def edit    
    @gossip = Gossip.find(params[:id])
  end

  def create
    @gossip = Gossip.new(title: params[:gossip_title], content: params[:gossip_content],user: User.find(1))  # avec xxx qui sont les données obtenues à partir du formulaire
    Gossip_tag.new(gossip_id: @gossip.id, tag: params[:select_tag])
    if @gossip.save # essaie de sauvegarder en base @gossip
        flash[:success] = "You successfuly created a gossip"
        redirect_to :action => 'show', :id => @gossip.id
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash.now[:danger] = "Error with the gossip creation"
      render :action => 'new'
    end
  end

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
    if @gossip.update(gossip_params)
      flash[:success] = "You successfuly edited a gossip"
      redirect_to action: "show", :id => @gossip.id
    else
      flash.now[:danger] = "Error with the gossip creation"
      render :action => 'edit'
    end
  end

  def destroy
    if Gossip.destroy(params[:id])
      flash[:success] = "You successfuly destroyed a gossip"
      redirect_to action: "index"
    else
      flash.now[:danger] = "Error with the gossip deletion"
      redirect_to action: "show", :id => params[:id]
    end
  end
end
