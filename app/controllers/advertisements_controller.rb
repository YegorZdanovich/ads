class AdvertisementsController < ApplicationController


  before_action :can_create?, only: [:new, :create]
  before_action :authenticate_user!, except: [:show]


  def new
    @ads = Advertisement.new
  end

  def create
    @user = current_user
    if @ads = @user.advertisements.create(params_for_create) 
      flash[:notice] = "New Advertisement was creat"
      redirect_to @ads
    else
      flash[:error] = "We can't crerate new ads.. sorry :("
      redirect_to root_path
    end
  end

  def show
    @ads = Advertisement.find_by(id: params[:id])
  end

  def update
    @ads = Advertisement.find_by(id: params[:id])
    
    param = choose_param
    if @ads.update(param)
      flash[:notice] = "Everything is update"
      redirect_to @ads
    else
      flash[:error] = "Bad news.. something goes wrong =("
      redirect_to @ads
    end
  end

  def destroy
    @ads = Advertisement.find(params[:id])
    @ads.destroy
    flash[:error] = "Advertisement was deleted."
    redirect_to root_path
  end

  private

  def params_for_create
    params.require(:advertisement).permit(:title, :text, :contact, images_attributes: [:picture])
  end

  def can_create?
    if cannot? :create, Advertisement
      flash[:error] = "Sorry bro, but you can't create new ads.."
      redirect_to root_path
    end
  end

  def choose_param
    if params[:commit] == "Update"
      params_for_update_ads
    else
      params_for_update_status
    end
  end

  def params_for_update_ads
    params.require(:advertisement).permit(:title, :text, :contact, :status)
  end

  def params_for_update_status
    params.require(:advertisement).permit(:status)
  end

end