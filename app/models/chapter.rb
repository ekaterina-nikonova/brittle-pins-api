class Chapter < ApplicationRecord
  belongs_to :project
  has_many :sections, -> { order(position: :asc) }, dependent: :destroy
  acts_as_list scope: :project

  validates :name, presence: true
end
