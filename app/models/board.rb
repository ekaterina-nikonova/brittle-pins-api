class Board < ApplicationRecord
  belongs_to :user
  has_many :projects
  has_and_belongs_to_many :components
  has_one_attached :image
end
