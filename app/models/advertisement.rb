class Advertisement < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # because doesn't recogmize column type
  self.inheritance_column = nil

  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy

  extend Enumerize
  enumerize :type, in: [:buy, :sale, :exchange], default: :buy


  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, presence: true, length: { in: 3..25 }
  validates :text, length: { maximum: 300 }
  validates :contact, length: { maximum: 60 }

  scope :time_post_order, -> { Advertisement.order("updated_at DESC") }
  scope :draft, -> { Advertisement.with_status(:draft) }
  scope :new_ads, -> { Advertisement.with_status(:new) }
  scope :canceled, -> { Advertisement.with_status(:canceled) }
  scope :approved, -> { Advertisement.with_status(:approved) }
  scope :published, -> { Advertisement.with_status(:published) }
  scope :archival, -> { Advertisement.with_status(:archival) }
  scope :without_draft, -> { where.not(status: :draft)}

  state_machine :status, :initial => :draft do

    event :create do
      transition :draft => :new
    end

    event :cancel do
      transition :new => :canceled
    end

    event :approve do
      transition :new => :approved
    end

    event :publish do
      transition :approved => :published
    end

    event :archiv do
      transition :published => :archival
    end

    event :to_draft do
      transition [:canceled, :archival] => :draft
    end
  end

end
