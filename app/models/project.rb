class Project < ApplicationRecord
  after_commit :notify_subscriber_of_addition, on: :create
  after_commit :notify_subscriber_of_deletion, on: :destroy

  belongs_to :user
  belongs_to :board
  has_and_belongs_to_many :components, uniq: true
  has_many :chapters, dependent: :destroy

  private

  def notify_subscriber_of_addition
    BrittlePinsApiSchema.subscriptions.trigger('projectAdded', {}, self)
  end

  def notify_subscriber_of_deletion
    BrittlePinsApiSchema.subscriptions.trigger('projectDeleted', {}, id)
  end
end
