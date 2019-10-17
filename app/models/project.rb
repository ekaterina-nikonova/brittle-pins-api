class Project < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_and_belongs_to_many :components, uniq: true
end
