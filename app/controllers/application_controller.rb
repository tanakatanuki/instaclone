class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  # フラッシュメッセージにnotice,alert以外のキーも許可
  add_flash_types :success, :info, :warning, :danger
end
