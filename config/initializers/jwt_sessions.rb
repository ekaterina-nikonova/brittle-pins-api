# frozen_string_literal: true

key = Rails.env.test? ? SecureRandom.hex(24) : Rails.application.secrets.secret_key_base

JWTSessions.encryption_key = key
