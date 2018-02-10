module SessionsHelper
  # ログインユーザーでないなら、セッション中のuser_idをキーにしてUsersテーブルからユーザー情報取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # ログイン状態ならtrue、そうでないならfalse
  def logged_in?
    !current_user.nil?
  end
  
  # ログインしていない場合、ログイン画面へとばす
  def authenticate_user
    if !logged_in?
      flash[:worning] = "ログインしてください"
      redirect_to new_session_path
    end
  end

end
