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
end
