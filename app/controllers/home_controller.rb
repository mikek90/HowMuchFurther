class HomeController < ApplicationController
  def index
    if current_user
      redirect_to tracks_path
    end
  end
end
