class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.content.blank? # もし、コメントが空だったら
      redirect_back(fallback_location: root_path)
    elsif @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" # renderメソッドは、指定されたビューファイルを表示するために使われる
    end
  end

 private

 def comment_params
  params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
 end     # ストロングパラメーターをセット 特定の値のみを受け付ける user_idとprototype_idもmergeした mergeは結合

end
