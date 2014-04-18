class HomeController < ApplicationController
  
  def index
    @search = Type.search(params[:q])
   
    if params[:q].present?
      # result return array, so get first elemen
      @adss = @search.result[0].advertisements.published
    else
      @adss = Advertisement.published
    end

    if params[:query].present?
      params[:q] = nil
      @adss = Advertisement.search(params[:query])
      @adss = @adss.records.published
    end

    @adss = @adss.time_post_order.page(params[:page]).per_page(10)
  end

end