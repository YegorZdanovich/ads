class AddAttachmentPictureToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :images, :picture
  end
end
