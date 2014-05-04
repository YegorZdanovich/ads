class ProfilesController < ApplicationController

  load_and_authorize_resource

  def update
    if @profile.update(params_for_update_profile)

      # update user's role from profile update form
      @user = @profile.user
      if params[:User].present?
        @user.role = params[:User][:role]
        @user.save
      end

      respond_with @profile
    else
      flash[:error] = @profile.errors.full_messages.to_sentence
      redirect_to @profile
    end
  end

  def destroy
    #delete user by deleting profile
    @user = User.find(Profile.find(params[:id]).user_id)
    @user.destroy
    respond_with current_user.profile
  end

  private

  def params_for_update_profile
    params.require(:profile).permit(:first_name, :second_name, :age)
  end

end
