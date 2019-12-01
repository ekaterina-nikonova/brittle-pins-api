# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email.downcase! }

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  validates :email,
            presence: true,
            format: { with: EMAIL_REGEX, on: :create },
            length: { maximum: 255 },
            uniqueness: { case_sensitive: false }

  validates :username,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }

  validates :password,
            presence: true,
            length: { minimum: 8 },
            allow_blank: true

  has_many :projects
  has_many :chapters
  has_many :sections
  has_many :boards
  has_many :components

  has_secure_password

  enum role: %i[user manager admin].freeze
end
