class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :prototype, foreign_key: true # prototypeを参照するための外部キーを記述
      t.references :user, foreign_key: true      # userを参照するための外部キーを記述

    
      t.timestamps
    end
  end
end
