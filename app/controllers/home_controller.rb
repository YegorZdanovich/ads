class HomeController < ApplicationController
  
  def index
    @adss = Advertisement.approved.time_post_order.page(params[:page]).per_page(3)
  end

end