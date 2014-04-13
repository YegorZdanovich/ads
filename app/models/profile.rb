class Profile < ActiveRecord::Base

  after_update :update_role_in_user

  belongs_to :user

  validates :first_name, presence: true
  validates :first_name, :second_name, length: { in: 1..100}
  validates :age, numericality: {only_integer: true}, inclusion: { in: 10..100}

  private

  #after updatin role in profile? update in user model
  def update_role_in_user
    User.find(self.user_id).update(role: self.role)
  end


end
