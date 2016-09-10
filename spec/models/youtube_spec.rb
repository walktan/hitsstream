require 'rails_helper'

RSpec.describe Youtube, type: :model do
  describe '#artist' do
    it { should validate_presence_of(:artist) }
    it { should validate_length_of(:artist).is_at_most(80) }
    it { should validate_uniqueness_of(:artist).scoped_to(:title) }
  end

  describe '#title' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
  end
end
