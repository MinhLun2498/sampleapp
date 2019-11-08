class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :created_at, ->{order created_at: :desc}
  scope :by_user, ->(id){where user_id: id}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content}
  validates :image, content_type: {in: Settings.image, message:
    I18n.t("must_be_a")},
    size: {less_than: Settings.n5.megabytes,
           message: I18n.t("should_be_less")}

  def display_image
    image.variant(resize_to_limit: [Settings.SIZE_MAX, Settings.SIZE_MAX])
  end
end
