class InstagsController < ApplicationController
  before_action :authenticate_user, only:[:new, :create, :edit, :update, :destroy, :show]
  # before_action :authenticate_user, only:[:new, :edit, :destroy, :show]
  before_action :forbid_instag, only:[:edit, :update, :destroy]
  before_action :set_instag, only: [:show, :edit, :update, :destroy]
  
  def index
    @instags = Instag.all
  end
  
  # confirm.htmlから戻ってきたとき、パラメで入力値を復元
  def new
    if params[:back]
      @instag = Instag.new(instag_params)
    else
      @instag = Instag.new
    end
  end
  
  def create
    # Instag.create(content: params[:instag][:content])
    @instag = Instag.new(instag_params)
    # ここでログインユーザーIDをinstagsテーブルに格納
    @instag.user_id = current_user.id
    # キャッシュから画像を復元
    @instag.image.retrieve_from_cache! params[:cache][:image]
    if @instag.save
      # 写真の保存時に、投稿ユーザーにメールを送る
      @user = User.find(current_user.id)
      ContactMailer.send_email(@user, @instag).deliver
      redirect_to instags_path
    else
      render new_instag_path
    end
  end
  
  def confirm
    @instag = Instag.new(instag_params)
    # userとinstagを紐付けたため、user_idをinstagテーブルに保存しないとエラー出る
    @instag.user_id = current_user.id
    render :new if @instag.invalid?
  end
  
  def edit
    # @instag = Instag.find(params[:id])
  end
  
  # 投稿一覧に飛ばすと、フラッシュメッセージが表示されなかったため、ユーザー情報にリダイレクト
  def update
    # @instag = Instag.find(params[:id])
    if @instag.update(instag_params)
    flash[:success] = "編集しました"
      # redirect_to instags_path
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def destroy
    # @instag = Instag.find(params[:id])
    @instag.destroy
    flash[:success] = "削除しました"
    # redirect_to instags_path
    redirect_to user_path(current_user.id)
  end
  
  # 詳細ページでは、投稿記事とお気に入りを表示する
  def show
    # @instag = Instag.fnd(params[:id])
    @favorite = current_user.favorites.find_by(instag_id: @instag.id)
  end
  
  
  private
  
  def instag_params
    params.require(:instag).permit(:content, :image, :user_id, :image_cache)
  end
  
  def set_instag
    @instag = Instag.find(params[:id])
  end
  
  # ログイン中、他人の投稿記事へのアクセス禁止
  def forbid_instag
    @instag = Instag.find(params[:id])
    if (logged_in?) && (current_user.id != @instag.user_id)
      redirect_to instags_path
    end
  end
end
