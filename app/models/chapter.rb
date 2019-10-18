class Chapter < ApplicationRecord
  belongs_to :project
  has_many :sections

  validates :name, presence: true
end
