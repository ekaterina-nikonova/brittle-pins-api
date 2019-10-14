require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  describe 'instance' do
    it 'is valid' do
      expect(user.valid?).to be(true)
    end

    it 'has a unique username' do
      u = User.create(username: 'test',
                      email: 'test@test.test',
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:username]).not_to be_blank
    end

    it 'has a unique, case-insensitive username' do
      u = User.create(username: 'TesT',
                      email: 'test@test.test',
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:username]).not_to be_blank
    end

    it 'has a unique email' do
      u = User.create(username: 'unique',
                      email: 'test@example.com',
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:email]).not_to be_blank
    end

    it 'has a unique, case-insensitive email' do
      u = User.create(username: 'unique',
                      email: 'Test@example.com',
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:email]).not_to be_blank
    end

    it 'has a password that is long enough' do
      u = User.create(username: 'unique',
                      email: 'unique@example.com',
                      password: 'test',
                      password_confirmation: 'test')
      expect(u.valid?).to be(false)
      expect(u.errors[:password]).not_to be_blank
    end

    it 'cannot have a too long email' do
      u = User.create(username: 'unique',
                      email: 'z' * 256,
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:email]).not_to be_blank
    end

    it 'cannot have a too long username' do
      u = User.create(username: 'z' * 51,
                      email: 'unique@test.com',
                      password: 'test12345',
                      password_confirmation: 'test12345')
      expect(u.valid?).to be(false)
      expect(u.errors[:username]).not_to be_blank
    end
  end
end
