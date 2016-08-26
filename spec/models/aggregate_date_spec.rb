require 'rails_helper'

RSpec.describe AggregateDate, :type => :model do
  describe "#this_date" do
    it { should validate_presence_of(:this_date) }
    it { should validate_uniqueness_of(:this_date) }
  end
end
