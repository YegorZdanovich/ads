class AdvertisementsController < ApplicationController


  before_action :can_create?, only: [:new, :create]

  load_and_authorize_resource except: [:new, :create]

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
    render "root/index"
  end

  def new
    @ads = Advertisement.new
  end

  def create
    @user = current_user
    @ads = @user.advertisements.create(params_for_create)
    if @ads.save
      Category.find_by(value: param_for_category).advertisements << @ads
      respond_with @ads
    else
      flash[:error] = @ads.errors.full_messages.to_sentence
      redirect_to new_advertisement_path
    end
  end

  def show
    @ads = Advertisement.find_by(id: params[:id])
  end

  def update
    @ads = Advertisement.find_by(id: params[:id])

    param = choose_param
    if @ads.update(param)
      respond_with @ads
    else
      flash[:error] = @ads.errors.full_messages.to_sentence
      redirect_to @ads
    end
  end

  def destroy
    @ads = Advertisement.find(params[:id])
    @ads.destroy
    respond_with @ads, :location => current_user.profile
  end

  private

  def params_for_create
    params.require(:advertisement).permit(:title, :text, :contact, :type, images_attributes: [:picture])
  end

  def param_for_category
    params.require(:advertisement).permit(:category)[:category]
  end

  def can_create?
    if cannot? :create, Advertisement
      flash[:error] = t 'ads.create.cannot'
      redirect_to root_path
    end
  end

  def choose_param
    if params[:commit] == (t 'update')
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
