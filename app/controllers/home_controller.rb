class HomeController < ApplicationController
  
  def index
    @ads = Advertisement.page(params[:page]).per_page(3)
  end

end