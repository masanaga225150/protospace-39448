class UsersController < ApplicationController

def show
  @user = User.find(params[:id]) # @userには、params[:id]で指定されたIDを持つユーザーの情報が取得されます。
  @user_name = @user.name        # @user_name:コントローラーのメソッド:インスタンス変数を定義すると、ビューファイル内で使用できる
  @comments = @user.comments
end

end
