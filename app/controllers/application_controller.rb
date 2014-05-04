require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protect_from_forgery with: :exception

  def check_admin_ability
    if cannot? :browse, Advertisement
      flash[:error] = t 'category.read.cannot'
      redirect_to root_path
    end
  end

end
