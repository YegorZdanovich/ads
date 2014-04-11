class Image < ActiveRecord::Base

  belongs_to :advertisement
 
  has_attached_file :picture, styles: { medium: "500x500>", thumb: "300x300>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
