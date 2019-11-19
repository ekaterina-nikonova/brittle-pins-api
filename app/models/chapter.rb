class Chapter < ApplicationRecord
  belongs_to :project
  has_many :sections, dependent: :destroy

  validates :name, presence: true
end
