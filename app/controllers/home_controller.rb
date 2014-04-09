class HomeController < ApplicationController
  
  def index
    @ads = Advertisement.all
  end

end