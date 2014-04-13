class Profile < ActiveRecord::Base

  belongs_to :user

  validates :first_name, presence: true
  validates :first_name, length: { in: 1..100}
  validates :second_name, length: { in: 1..100}, on: :update
  validates :age, numericality: {only_integer: true}, inclusion: { in: 10..100}, on: :update

end
