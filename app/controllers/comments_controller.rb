class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params) # @comment = Comment.newというインスタンス変数を生成しておく
    if @comment.save
      redirect_to prototype_path(@comment.prototype) # @commentはCommentモデルのインスタンスであり、prototypeという関連付けを持っているため、
                                                     # @comment.prototypeとすることで、そのコメントが対象となるプロトタイプを取得することができる。
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
