class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(instag_id: params[:instag_id])
    flash[:success] = "お気に入りに登録しました"
    redirect_to instag_path(favorite.instag.id)
  end

  def destroy
    favorite = current_user.favorites.find_by(instag_id: params[:instag_id]).destroy
    flash[:success] = "お気に入りを解除しました"
    redirect_to instag_path(favorite.instag.id)
  end    
end
