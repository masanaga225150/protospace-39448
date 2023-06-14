class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ログインしていないユーザーをログインページの画面に促すことができる。
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters # Deviseを使用する際に、サインアップ時に追加で受け付けるパラメータを指定する際に、サインアップ時に追加で受け付けるパラメータを指定するためのメソッド
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :profile, :occupation, :position])
  end
end
