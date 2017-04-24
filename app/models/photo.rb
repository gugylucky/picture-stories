class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { medium: "900x900>", thumb: "600x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates_attachment_presence :image
end
