class Invitation < ApplicationRecord
  belongs_to :user
  before_validation :generate_code

  private

  def generate_code
    self.code = [*'A'..'Z', *'a'..'z', *0..9].sample(8).join
  end
end
