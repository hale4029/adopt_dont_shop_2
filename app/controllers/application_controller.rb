class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @favorites = Favorite.new(session[:favorite])
  end

end
