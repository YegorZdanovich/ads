class ProfilesController < ApplicationController

  before_action :authenticate_user!
  before_action :is_users_profile?, only: [:show, :edit]

  def show
    @profile = Profile.find_by(id: params[:id])
  end

  def edit
    @profile = Profile.find_by(id: params[:id])
  end

  def update
    @profile = Profile.find_by(id: params[:id])
    if @profile.update(params_for_update_profile)

      flash[:notice] = "Everything is update"
      redirect_to @profile
    else
      flash[:error] = "Bad news.. something goes wrong =("
      redirect_to @profile
    end
  end

  private

  def is_users_profile?
    unless Profile.find_by(id: params[:id]).user_id == current_user.id
      redirect_to profile_path(current_user.profile)
    end
  end

  def params_for_update_profile
    params.require(:profile).permit(:first_name, :second_name, :age, :role)
  end

  def update_user_role
    params.require(:profile).permit(:role)
  end
end