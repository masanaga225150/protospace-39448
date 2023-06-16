class ApplicationController < ActionController::Base
  before_action :authenticate_user! # ログインしていないユーザーをログインページの画面に促すことができる。
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :basic_auth

  private
  def configure_permitted_parameters # Deviseを使用する際に、サインアップ時に追加で受け付けるパラメータを指定する際に、サインアップ時に追加で受け付けるパラメータを指定するためのメソッド
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :profile, :occupation, :position])
  end

  # def basic_auth
    # authenticate_or_request_with_http_basic do |username, password|
      # username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    # end
  # end
end
