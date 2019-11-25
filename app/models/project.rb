class Project < ApplicationRecord
  after_create_commit :notify_subscriber_of_addition
  after_destroy_commit :notify_subscriber_of_deletion
  after_update_commit :notify_subscriber_of_update

  belongs_to :user
  belongs_to :board
  has_and_belongs_to_many :components, uniq: true
  has_many :chapters, -> { order(position: :asc) }, dependent: :destroy

  private

  def notify_subscriber_of_addition
    BrittlePinsApiSchema.subscriptions.trigger('projectAdded', {}, self)
  end

  def notify_subscriber_of_deletion
    BrittlePinsApiSchema.subscriptions.trigger('projectDeleted', {}, id)
  end

  def notify_subscriber_of_update
    BrittlePinsApiSchema.subscriptions.trigger('projectUpdated', {}, self)
  end
end
