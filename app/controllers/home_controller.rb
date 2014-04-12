class HomeController < ApplicationController
  
  def index
    @search = Type.search(params[:q])
   
    if params[:q].present?
      # result return array, so get first elemen
      @adss = @search.result[0].advertisements.published
    else
      @adss = Advertisement.published
    end
  end

end