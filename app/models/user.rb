class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  
  # DBへ保存前に、emailを小文字にする
  before_save {email.downcase!}
  
  # パスワードをハッシュ化するため、has_secure_passwordメソッドを使う
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  
  # 作成者機能(instagモデルと)のアソシエーション。1側
  has_many :instags, dependent: :destroy
  
  # お気に入りのアソシエーション。1側
  has_many :favorites, dependent: :destroy
  has_many :favorite_instags, through: :favorites, source: :instag
end
