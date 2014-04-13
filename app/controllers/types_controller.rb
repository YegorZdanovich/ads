class TypesController < ApplicationController

  before_action :check_ability

  def index
    @type = Type.all
  end

  def create
    @type = Type.create(params_for_create)
    if @type.save
      flash[:notice] = "New Type was created!"
    else
      flash[:error] = @type.errors.full_messages.to_sentence
    end
    redirect_to types_path
  end

  def destroy
    @type = Type.find(params[:id])
    if @type.destroy
      flash[:notice] = "Type was deleted."
    else
      flash[:error] = @type.errors.full_messages.to_sentence
    end
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