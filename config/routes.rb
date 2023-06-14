Rails.application.routes.draw do
  devise_for :users
  root to: 'prototypes#index' # 遷移するように設定。 実行するアクションはprototypesコントローラーのindexアクション
  resources :prototypes do    # ...アクションへのルーティングを設定
   resources :comments, only: :create # 親となるコントローラーprorotypes 子となるコントローラーcomments
                                      # ルーティングのネスト
  end
  resources :users do
    get 'show', on: :member
  end  # /users/:idのパスでリクエストした際にusers_controller.rbのshowアクションを実行するルーティングが設定できた。
end
