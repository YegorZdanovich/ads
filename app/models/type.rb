class Type < ActiveRecord::Base

  has_many :advertisements, dependent: :restrict_with_error

  validates :value, presence: true, length: { maximum: 20}, uniqueness: true
end
