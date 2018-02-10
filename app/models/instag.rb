class Instag < ApplicationRecord
  validates :content, presence: true, length: {in: 1..140}
  
  # Userモデルとのアソシエーション。多側
  belongs_to :user
  
  # お気に入りのアソシエーション。1側
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  # 画像アップローダの設定
  mount_uploader :image, ImageUploader
  
end
