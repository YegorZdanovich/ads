class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_one :profile, dependent: :destroy
  has_many :advertisements, dependent: :nullify 

  extend Enumerize
  enumerize :role, in: [:guest, :user, :admin], default: :guest

  # set default role for signed_in users
  before_create :set_role
  after_create :create_profile


  private

  def set_role
    self.role = :user
  end

  def create_profile
    Profile.create(first_name: self.email, user_id: self.id, role: self.role)
  end

end
