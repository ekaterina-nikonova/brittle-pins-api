# frozen_string_literal: true

key = Rails.env.test? ? SecureRandom.hex(24) : Rails.application.secrets.secret_key_base

JWTSessions.encryption_key = key

JWTSessions.algorithm = 'RS256'
JWTSessions.private_key = OpenSSL::PKey::RSA.generate(2048)
JWTSessions.public_key = JWTSessions.private_key.public_key
