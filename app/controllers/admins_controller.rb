class AdminsController < ApplicationController

  before_action :check_ability

  def users
    @users = User.all.page(params[:page]).per_page(10)
  end

  def all_ads
     @adss = Advertisement.without_draft.page(params[:page]).per_page(20)
  end

  def types
    @types = Type.all
  end

  private

  def check_ability
    if cannot? :browse, Advertisement
      flash[:error] = t 'type.read.cannot'
      redirect_to root_path
    end
  end

end