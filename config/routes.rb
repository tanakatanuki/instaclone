Rails.application.routes.draw do
  get 'sessions/new'

  # ユーザー情報
  resources :users, only:[:new, :create, :show]
  
  # ログイン情報
  resources :sessions, only:[:new, :create, :destroy]
  
  # インスタ本体
  resources :instags do
    # お気に入り
    resources :favorites, only:[:create, :destroy]
    # 確認画面
    collection do
      post :confirm
    end
  end
  
  #　開発環境下でのメール機能確認
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at:"/letter_opener"
  end

end
