class AdminsController < ApplicationController

  before_action :check_admin_ability

  def users
    @users = User.all.page(params[:page]).per_page(10)
  end

  def all_ads
     @adss = Advertisement.without_draft.time_post_order.page(params[:page]).per_page(20)
  end

  def categories
    @categories = Category.all
  end

end
