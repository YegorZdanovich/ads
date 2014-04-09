class AdvertisementsController < ApplicationController


  before_action :check_ability, only: [:new, :create]
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

  def destroy
    @ads = Advertisement.find(params[:id])
    @ads.destroy
    flash[:error] = "Advertisement was deleted."
    redirect_to root_path
  end

  private

  def params_for_create
    params.require(:advertisement).permit(:title, :text, :contact)
  end

  def check_ability
    if cannot? :create, Advertisement
      flash[:error] = "Sorry bro, but you can't create new ads.."
      redirect_to root_path
    end
  end
end