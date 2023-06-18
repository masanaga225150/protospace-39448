class UsersController < ApplicationController
 def show
   @user = User.find(params[:id]) # @userには、params[:id]で指定されたIDを持つユーザーの情報が取得されます。
 end
end
