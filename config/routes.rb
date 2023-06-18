Rails.application.routes.draw do
  devise_for :users
  root to: 'prototypes#index' # 遷移するように設定。 実行するアクションはprototypesコントローラーのindexアクション
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do    # ...アクションへのルーティングを設定
    resources :comments, only: :create # 親となるコントローラーprorotypes 子となるコントローラーcomments
    # resourcesルーティングが生成される。  # ルーティングのネスト []のルートだけが生成される。プロトタイプに関連するコメントのルーティングを定義している。リソースの関連性を表現することができる。
        # ネストさせる一番の理由は、アソシエーション先のレコードのidをparamsに追加してコントローラーに送るため
  end
  resources :users, only: :show
end
