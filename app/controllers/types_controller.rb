class TypesController < ApplicationController

  before_action :check_ability

  def index
    @type = Type.all
  end

  def create
    if @type = Type.create(params_for_create)
      flash[:notice] = "New Type was created!"
    else
      flash[:error] = "Error in creating new type"
    end
    redirect_to types_path
  end

  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    flash[:error] = "Type was deleted."
    redirect_to types_path
  end

  private

  def params_for_create
    params.require(:type).permit(:value)
  end

  def check_ability
    if cannot? :browse, Advertisement
      flash[:error] = "Permission denied"
      redirect_to root_path
    end
  end

end