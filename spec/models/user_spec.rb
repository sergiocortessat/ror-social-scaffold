require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
  end

  describe 'associations' do
    it { should have_many(:comments) }
  end

  describe 'associations' do
    it { should have_many(:likes) }
  end
  describe 'associations' do
    it { should have_many(:friends) }
  end
  describe 'associations' do
    it { should have_many(:pending_friendships) }
  end
  describe 'associations' do
    it { should have_many(:confirmed_friendships) }
  end
  describe 'associations' do
    it { should have_many(:inverse_friendships) }
  end
  describe 'associations' do
    it { should have_many(:pending_friends) }
  end
  describe 'associations' do
    it { should have_many(:friend_requests) }
  end
end
