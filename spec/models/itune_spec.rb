require 'rails_helper'

RSpec.describe Itune, type: :model do
  describe "#genre" do
    it { should validate_presence_of(:genre) }
    it { should validate_uniqueness_of(:genre) }
    it { should validate_length_of(:genre).is_at_most(30) }
  end

  describe "#itunes_url" do
    it { should validate_presence_of(:itunes_url) }
    it { should allow_value("https://itunes.apple.com/jp/rss/topsongs/" \
                              + "limit=10/genre=15/xml").for(:itunes_url) }
    it { should_not allow_value("//itunes.apple.com/jp/rss/").for(:itunes_url) }
  end
end
