class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except:[:index, :show] # 全てのアクションの前に、ユーザーがログインしているかどうか確認する
                                                            # ただし、showアクションと、indexアクションが呼び出された場合は、除く
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
    # prototypeモデルに関連づけられたUserモデルのデータを一度に読み込むために使用されます。
    # includesメソッドを使用することで、prototypeモデルの全レコードに対して、関連するUserモデルのデータを事前に読み込むことができます。これにより、N+1問題を回避し、パフォーマンスを向上させることができます。
    
  end

  def new
    @prototype = Prototype.new # Prototypeモデルのオブジェクトを作成するためには、newメソッドを使用します。
                               # このメソッドは、Prototypeクラスの新しいインスタンスを作成し、そのインスタンスを@prototype変数に割り当てます。
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new          # 新しいCommentオブジェクトを作成する
    @comments = @prototype.comments # @prototypeに紐づいた全てのコメントを取得するために使用されます。
    # @comments変数は、ビューで使用されることが多いです。例えば、<% @comments.each do |comment| %>
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
    # rnlessキーワードは、条件がfalseの場合に実行される。current_user == @prototype.userの条件がfalseである場合に、リダイレクトするためのコードを実行します。
    # ログインしているユーザーがprototypeを作成したユーザーでない場合に、トップページにリダイレクトするためのものです。

  end
end
