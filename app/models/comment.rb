class Comment < ApplicationRecord
  belongs_to :prototype # prototypesテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
                    # アソシエーションでbelongs_toを指定した場合、user_idが「空ではないか」というバリデーションは、デフォルトでかかっている。

  validates :content, presence: true      # 空の場合はDBに保存しない
            # content情報やデータ モデルの属性が空値でないことを検証できます。
end
