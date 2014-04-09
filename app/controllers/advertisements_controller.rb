class AdvertisementsController < ApplicationController

  def new
    @ads = Advertisement.new
  end

  def create
    @ads = Advertisement.new(params_for_create)
    if @ads.save
      flash[:notice] = "New Advertisement was creat"
      redirect_to @ads
    else
      flash[:error] = "We can't crerate new ads.. sorry :("
      redirect_to @ads
    end
  end

  def show
    @ads = Advertisement.find_by(id: params[:id])
  end

  private

  def params_for_create
    params.require(:advertisement).permit(:title, :text, :contact)
  end

end