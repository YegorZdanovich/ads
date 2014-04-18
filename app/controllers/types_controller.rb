class TypesController < ApplicationController

  before_action :check_ability

  def index
    @type = Type.all
  end

  def create
    @type = Type.create(params_for_create)
    if @type.save
      respond_with types_path, :location => types_path
    else
      flash[:error] = @type.errors.full_messages.to_sentence
      redirect_to types_path
    end
  end

  def destroy
    @type = Type.find(params[:id])
    if @type.destroy
      respond_with types_path, :location => types_path
    else
      flash[:error] = @type.errors.full_messages.to_sentence
      redirect_to types_path
    end
  end

  private

  def params_for_create
    params.require(:type).permit(:value)
  end

  def check_ability
    if cannot? :browse, Advertisement
      flash[:error] = t 'type.read.cannot'
      redirect_to root_path
    end
  end

end