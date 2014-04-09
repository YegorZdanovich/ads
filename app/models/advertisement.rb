class Advertisement < ActiveRecord::Base
  
  scope :time_post_order, -> { Advertisement.order("created_at DESC") }

  belongs_to :user

end
