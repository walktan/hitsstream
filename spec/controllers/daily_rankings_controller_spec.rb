require 'rails_helper'

RSpec.describe DailyRankingsController, type: :controller do
  describe "POST #index" do
    context "TOPページにアクセスしたとき" do
      before { post :index }
      it "ステータスコードとして200が返ること" do
        expect(response.status).to eq 200
      end
      it "@aggregate_date_idがnilでないこと" do
        expect(assigns(:aggregate_date_id)).not_to be_nil
      end
      it "@itune_idがnilでないこと" do
        expect(assigns(:itune_id)).not_to be_nil
      end
      it "@running_rankingがnilでないこと" do
        expect(assigns(:running_ranking)).not_to be_nil
      end
      it "@view_rankingsがnilでないこと" do
        expect(assigns(:view_rankings)).not_to be_nil
      end
      it "@list_datesがnilでないこと" do
        expect(assigns(:list_dates)).not_to be_nil
      end
      it "@list_genresがnilでないこと" do
        expect(assigns(:list_genres)).not_to be_nil
      end
    end

    context "Edit画面からTOPページに戻ったとき" do
      before do
        flash_hash = ActionDispatch::Flash::FlashHash.new
        flash_hash[:itune_id] = 1
        flash_hash[:target_date_id] = 1
        flash_hash[:running_ranking] = 2
        session['flash'] = flash_hash.to_session_value
        post :index
      end
      it "ステータスコードとして200が返ること" do
        expect(response.status).to eq 200
      end
      it "@target_date_idがnilでないこと" do
        expect(assigns(:target_date_id)).not_to be_nil
      end
      it "@itune_idがnilでないこと" do
        expect(assigns(:itune_id)).not_to be_nil
      end
      it "@running_rankingがnilでないこと" do
        expect(assigns(:running_ranking)).not_to be_nil
      end
      it "@view_rankingsがnilでないこと" do
        expect(assigns(:view_rankings)).not_to be_nil
      end
      it "@list_datesがnilでないこと" do
        expect(assigns(:list_dates)).not_to be_nil
      end
      it "@list_genresがnilでないこと" do
        expect(assigns(:list_genres)).not_to be_nil
      end
    end
  end

  describe "POST #result" do
    context "selectボタンまたはサムネイルがクリックされたとき" do
      before do
        @target_date_id = 1
        @itune_id = 1
        @running_ranking = 4
        xhr :post, :result, { target_date_id: @target_date_id \
                          , itune_id: @itune_id \
                          , running_ranking: @running_ranking }
      end
      it "ステータスコードとして200が返ること" do
        expect(response.status).to eq 200
      end
      it "@running_rankingがnilでないこと" do
        expect(assigns(:running_ranking)).not_to be_nil
      end
      it "@view_rankingsがnilでないこと" do
        expect(assigns(:view_rankings)).not_to be_nil
      end
      it "@list_datesがnilでないこと" do
        expect(assigns(:list_dates)).not_to be_nil
      end
      it "@list_genresがnilでないこと" do
        expect(assigns(:list_genres)).not_to be_nil
      end
    end
  end

  describe "POST #next" do
    context "nextボタンがクリックされたとき" do
      before do
        @target_date_id = 1
        @itune_id = 1
        @running_ranking = 4
        xhr :post, :next, { target_date_id: @target_date_id \
                          , itune_id: @itune_id \
                          , running_ranking: @running_ranking }
      end
      it "ステータスコードとして200が返ること" do
        expect(response.status).to eq 200
      end
      it "@running_rankingがnilでないこと" do
        expect(assigns(:running_ranking)).not_to be_nil
      end
      it "@view_rankingsがnilでないこと" do
        expect(assigns(:view_rankings)).not_to be_nil
      end
      it "@list_datesがnilでないこと" do
        expect(assigns(:list_dates)).not_to be_nil
      end
      it "@list_genresがnilでないこと" do
        expect(assigns(:list_genres)).not_to be_nil
      end
    end
  end

  describe "POST #prex" do
    context "prevボタンがクリックされたとき" do
      before do
        @target_date_id = 1
        @itune_id = 1
        @running_ranking = 4
        xhr :post, :prev, { target_date_id: @target_date_id \
                          , itune_id: @itune_id \
                          , running_ranking: @running_ranking }
      end
      it "ステータスコードとして200が返ること" do
        expect(response.status).to eq 200
      end
      it "@running_rankingがnilでないこと" do
        expect(assigns(:running_ranking)).not_to be_nil
      end
      it "@view_rankingsがnilでないこと" do
        expect(assigns(:view_rankings)).not_to be_nil
      end
      it "@list_datesがnilでないこと" do
        expect(assigns(:list_dates)).not_to be_nil
      end
      it "@list_genresがnilでないこと" do
        expect(assigns(:list_genres)).not_to be_nil
      end
    end
  end
end
