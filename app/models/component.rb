class Component < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :boards, uniq: true
  has_and_belongs_to_many :projects, uniq: true
end
