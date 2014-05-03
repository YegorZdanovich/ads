class AdsController < ApplicationController

  def index

    @search = Category.search(params[:q])

    names = Category.pluck(:value)

    #return not empty categories with their advertisements count
    array = Advertisement.published.joins(:category).group("value").select("value, COUNT(*) as num").map{|c| [c.value, c.num] }
    @category = Hash[array]

    # set to '0' empty categories
    names.each{|name| @category[name] ||= 0}

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
