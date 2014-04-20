class HomeController < ApplicationController
  
  def index

    @search = Category.search(params[:q])
     
    if params[:q].present?

      # result return array, so get first elemen
      @adss = @search.result[0].advertisements
    else
      @adss = Advertisement.all
    end

    if params[:query].present?
      @adss = Advertisement.search(params[:query])
      @adss = @adss.records
    end

    if params[:facet].present?
      @adss = Category.find_by(value: params[:facet]).advertisements
    end

    @adss = @adss.published.time_post_order.page(params[:page]).per_page(10)
  end

end