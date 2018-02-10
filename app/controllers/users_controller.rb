class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  
  # viewで、ユーザー情報と投稿写真、お気に入り一覧を表示
  def show
    @user = User.find(params[:id])
    @post_instag = Instag.where(user_id: params[:id])
    @favorite_instag = @user.favorite_instags
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # ログイン中、自分のユーザー情報のみ編集できる(直リン許さない)
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to instags_path
    end
  end
end
