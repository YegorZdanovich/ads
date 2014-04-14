class HomeController < ApplicationController
  
  def index
    @search = Type.search(params[:q])
   
    if params[:q].present?
      # result return array, so get first elemen
      @adss = @search.result[0].advertisements.published.page(params[:page]).per_page(10)
    else
      @adss = Advertisement.published.page(params[:page]).per_page(10)
    end
  end

end