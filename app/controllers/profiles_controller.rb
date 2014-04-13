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

      # update user's role from profile update form
      @user = @profile.user
      if params[:User].present? 
        @user.role = params[:User][:role]
        @user.save
      end

      flash[:notice] = "Everything is update"
      redirect_to @profile
    else
      flash[:error] = @profile.errors.full_messages.to_sentence
      redirect_to @profile
    end
  end

  def destroy
    #delete user by deleting profile
    @user = User.find(Profile.find(params[:id]).user_id)
    @user.destroy    
    flash[:error] = "User was deleted."
    redirect_to root_path
  end

  private

  def is_users_profile?
    if cannot? :read, Profile.find_by(id: params[:id])
      flash[:error] = "it was private profile!"
      redirect_to profile_path(current_user.profile)
    end
  end

  def params_for_update_profile
    params.require(:profile).permit(:first_name, :second_name, :age)
  end

end