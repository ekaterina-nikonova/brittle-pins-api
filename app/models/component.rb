class Component < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :boards
  has_and_belongs_to_many :projects
end
