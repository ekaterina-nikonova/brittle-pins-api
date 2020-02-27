class Board < ApplicationRecord
  after_create_commit :notify_subscriber_of_addition
  after_destroy_commit :notify_subscriber_of_deletion
  after_update_commit :notify_subscriber_of_update

  belongs_to :user
  has_many :projects
  has_and_belongs_to_many :components, uniq: true
  has_one_attached :image

  private

  def notify_subscriber_of_addition
    BrittlePinsApiSchema.subscriptions.trigger('boardAdded', {}, self)
  end

  def notify_subscriber_of_deletion
    BrittlePinsApiSchema.subscriptions.trigger('boardDeleted', {}, id)
  end

  def notify_subscriber_of_update
    BrittlePinsApiSchema.subscriptions.trigger('boardUpdated', {}, self)
  end
end
