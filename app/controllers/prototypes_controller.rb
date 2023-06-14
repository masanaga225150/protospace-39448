class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # ログインしていないユーザーは、新規プロトタイプの投稿画面にアクセスすることができず、ログイン画面にリダイレクトされます。
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  # これらのアクションでのプロトタイプの検索を繰り返し行う必要がなくなります。

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new # newアクションをコントローラに定義する。投稿画面(new.html.erb)でform_withというヘルバーメソッドを使用しますが、その際にこのインスタンス変数が必要となるためです。
  end                          # 投稿ページへ遷移する処理を行う(newアクション) 

  def create # テーブルへ登録する処理を行う(createアクション)
    @prototype = Prototype.new(prototype_params)
    # 投稿されたprototypeデータと投稿主のuser_idを関連づけて保存。
    if @prototype.save
      redirect_to root_path
    else
      # 新規投稿フォームに戻る。
      render :new
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'プロトタイプを削除しました'
  end

  def update # テーブルへ更新する処理を行う(updateアクション)
    if @prototype.update(prototype_params) # 取得したプロトタイプの情報をもとに、データベース上のレコードを更新するためのメソッドです。
      redirect_to @prototype, notice: 'プロトタイプの編集が完了しました' # 更新が瀬宇高した場合は、redirect_toメソッドを使用して、詳細ページにリダイレクトします。
    else                
      render :edit      # 呼び出すビューファイルを指定するメソッド データが更新されなかったときは、編集ページに戻るようにrenderを使用
    end
  end

  def show
    @comment = @prototype.comments.build # @prototypeに紐づくコメントの新規作成フォームを表示することができます。
    @comments = @prototype.comments.includes(:user) # includesメソッドは、N+1問題を回避するために使用される
                                                    # インスタンス変数@commentsを定義し、その投稿に紐づく全てのコメントを代入する@prototype = Prototype.find(params[:id]) # @prototypeには、params[:id]で指定されたIDを持つプロトタイプの情報が取得されます。
  end

  def edit # アクションを設定 # 編集ページへ遷移する処理を行う(editアクション)
                 # editアクションで生成したインスタンスを、form_withで利用する
    
  end



  private

 
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params # ストロングパラメーター
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end      # prototype_paramsの中でpermitメソッドを使用し、:title, :catch_copy, :concept, :imageの編集を許可する。
           # current_user:現在ログインしているユーザーの情報を取得できる
           # mergeメソッド:paramsとuser_idの情報を統合
   
   
  def move_to_index
   unless user_signed_in?
    redirect_to action: :index
   end
  end
          


end
