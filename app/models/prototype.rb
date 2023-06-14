class Prototype < ApplicationRecord
  has_many :comments, dependent: :destroy # commentsテーブルとのアソシエーション
                      # 親モデルprototype.子モデルcomments 親と一緒に子も削除する dependentオプション
  belongs_to :user    # usersテーブルとのアソシエーション
  has_one_attached :image

  validates :title, presence: true        # 「name」カラムにpresence: trueを設けることで、からの場合はDBに保存しないというバリデーションを設定しています。
  validates :catch_copy, presence: true   # つまり、ユーザー登録時に「name」を空欄にして登録しようとすると、エラーが発生します。
  validates :concept, presence: true
  validates :image, presence: true

 

end