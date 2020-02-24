class Component < ApplicationRecord
  after_create_commit :notify_subscriber_of_addition
  after_destroy_commit :notify_subscriber_of_deletion
  after_update_commit :notify_subscriber_of_update

  belongs_to :user
  has_and_belongs_to_many :boards, uniq: true
  has_and_belongs_to_many :projects, uniq: true
  has_one_attached :image

  private

  def notify_subscriber_of_addition
    BrittlePinsApiSchema.subscriptions.trigger('componentAdded', {}, self)
  end

  def notify_subscriber_of_deletion
    BrittlePinsApiSchema.subscriptions.trigger('componentDeleted', {}, id)
  end

  def notify_subscriber_of_update
    BrittlePinsApiSchema.subscriptions.trigger('componentUpdated', {}, self)
  end
end
