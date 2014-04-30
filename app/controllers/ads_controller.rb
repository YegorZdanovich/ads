class AdsController < ApplicationController

  def index

    @search = Category.search(params[:q])
    @category = Category.includes(:advertisements)

    if params[:q].present?
      params[:facet] = nil
      @adss = Advertisement.order(params[:q][:s])
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

    @adss = @adss.includes(:category).published.time_post_order.page(params[:page]).per_page(10)
  end

end
