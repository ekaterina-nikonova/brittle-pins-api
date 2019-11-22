# Building block in Project - Chapter - Section (image, paragraph, code)
class Section < ApplicationRecord
  belongs_to :chapter
  has_one_attached :image
  acts_as_list scope: :chapter

  validates :paragraph, presence: true
end
