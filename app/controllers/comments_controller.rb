class CommentsController < ApplicationController
  before_filter :get_parent, only: :create
  before_filter :correct_user, only: :destroy
  def new
    @comment = @parent.comments.build
    @comment.user = current_user
  end

 def show

	@comment = Comment.find_by_id(params[:id])
	@comments = @comment.comments.paginate(page: params[:page])
 end

  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Commented"
      redirect_to @parent
    else
      render :new
    end
  end
  

  def destroy
    @comment.destroy if @comment
    redirect_to @parent 
  end

protected
  
def get_parent
  @parent = Link.find_by_id(params[:link_id]) if params[:link_id]
  @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
end

def correct_user
       
       @comment = current_user.comments.find_by_id(params[:id])
	@parent = @comment.commentable       
	redirect_to @parent if @comment.nil?
       
end

end