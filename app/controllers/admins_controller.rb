class AdminsController < ApplicationController

  def users
    @users = User.all.page(params[:page]).per_page(10)
  end

  def all_ads
     @adss = Advertisement.all
  end

end