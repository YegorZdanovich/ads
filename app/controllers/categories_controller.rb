class CategoriesController < ApplicationController

  before_action :check_admin_ability

  def index
    @category = Category.all
  end

  def create
    @category = Category.create(params_for_create)
    if @category.save
      respond_with categories_path, :location => categories_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      redirect_to categories_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      respond_with categories_path, :location => categories_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      redirect_to categories_path
    end
  end

  private

  def params_for_create
    params.require(:category).permit(:value)
  end

end
