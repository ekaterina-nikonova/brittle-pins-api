# frozen_string_literal: true

# Helper for user spec

module AuthHelper
  def sign_in_as(user)
    payload = { user_id: user.id, aud: [user.role] }
    session = JWTSessions::Session.new(payload: payload)
    tokens = session.login
    request.cookies[JWTSessions.access_cookie] = tokens[:access]
    request.headers[JWTSessions.csrf_header] = tokens[:csrf] # for post/patch/delete requests
  end
end
