class Profile < ActiveRecord::Base

  after_update :update_role_in_user

  belongs_to :user


  private

  #after updatin role in profile? update in user model
  def update_role_in_user
    User.find(self.user_id).update(role: self.role)
  end


end
