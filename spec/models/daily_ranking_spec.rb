require 'rails_helper'

RSpec.describe DailyRanking, type: :model do
  describe '#aggregate_date_id' do
    it { should validate_presence_of(:aggregate_date_id) }
  end

 describe '#itune_id' do
    it { should validate_presence_of(:itune_id) }
  end

  describe '#youtube_id' do
    it { should validate_presence_of(:youtube_id) }
  end

  describe '#rank' do
    it { should validate_presence_of(:rank) }
    it { should ensure_inclusion_of(:rank).in_range(1..10) }
  end

  describe 'ranking method' do
    context 'aggregate_date_id == 1 かつ itune_id == 1のとき' do
      it 'nil でないこと' do
        ranking = DailyRanking.ranking(1,1)
        expect(ranking).not_to be_nil
      end
    end
  end

  describe 'next_ranking method' do
    context 'now_ranking == 3のとき' do
      it 'next_ranking == 4 であること' do
        now_ranking = 3
        next_ranking = DailyRanking.next_ranking(now_ranking)
        expect(next_ranking).to eq 4
      end
    end
    context 'now_ranking == 10のとき' do
      it 'next_ranking == 1 であること' do
        now_ranking = 10
        next_ranking = DailyRanking.next_ranking(now_ranking)
        expect(next_ranking).to eq 1
      end
    end
  end

  describe 'prev_ranking method' do
    context 'now_ranking == 3のとき' do
      it 'prev_ranking == 2 であること' do
        now_ranking = 3
        prev_ranking = DailyRanking.prev_ranking(now_ranking)
        expect(prev_ranking).to eq 2
      end
    end
    context 'now_ranking == 1のとき' do
      it 'prev_ranking == 10 であること' do
        now_ranking = 1
        prev_ranking = DailyRanking.prev_ranking(now_ranking)
        expect(prev_ranking).to eq 10
      end
    end
  end
end
