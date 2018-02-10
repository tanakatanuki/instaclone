class Favorite < ApplicationRecord
  # お気に入りアソシエーション。中間
  belongs_to :user
  belongs_to :instag
end
