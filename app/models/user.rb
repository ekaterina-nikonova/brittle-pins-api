# frozen_string_literal: true

class User < ApplicationRecord
  has_many :boards
  has_many :components

  has_secure_password
end
