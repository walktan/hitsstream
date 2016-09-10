require 'rails_helper'

RSpec.describe YoutubesController, type: :controller do
  describe 'GET #edit' do
    context 'Editページにアクセスしたとき' do
      before do
        @id = 2
        @target_date_id = 1
        @itune_id = 1
        @running_ranking = 4
        get :edit, { id: @id \
        	         , target_date_id: @target_date_id \
                   , itune_id: @itune_id \
                   , running_ranking: @running_ranking }
      end
      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq 200
      end
      it '@youtubeがnilでないこと' do
        expect(assigns(:youtube)).not_to be_nil
      end
      it '@new_urlがnilでないこと' do
        expect(assigns(:new_url)).not_to be_nil
      end
      it 'flash[:target_date_id]がnilでないこと' do
        expect(flash[:target_date_id]).not_to be_nil
      end
      it 'flash[:itune_id]がnilでないこと' do
        expect(flash[:itune_id]).not_to be_nil
      end
      it 'flash[:running_ranking]がnilでないこと' do
        expect(flash[:running_ranking]).not_to be_nil
      end
    end
  end

  describe 'POST #confirm' do
    context '[MVの内容を確認する]ボタンをクリックしたとき' do
      before do
        @id = 2
        @new_url = '8szBN__ZSQ8'
        flash_hash = ActionDispatch::Flash::FlashHash.new
        flash_hash[:target_date_id] = 1
        flash_hash[:itune_id] = 1
        flash_hash[:running_ranking] = 2
        session['flash'] = flash_hash.to_session_value
        xhr :post, :confirm, { id: @id \
                             , new_url: @new_url }
      end
      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq 200
      end
      it '@youtubeがnilでないこと' do
        expect(assigns(:youtube)).not_to be_nil
      end
      it '@new_urlがnilでないこと' do
        expect(assigns(:new_url)).not_to be_nil
      end
      it 'flash[:target_date_id]がnilでないこと' do
        expect(flash[:target_date_id]).not_to be_nil
      end
      it 'flash[:itune_id]がnilでないこと' do
        expect(flash[:itune_id]).not_to be_nil
      end
      it 'flash[:running_ranking]がnilでないこと' do
        expect(flash[:running_ranking]).not_to be_nil
      end
    end
  end

  describe 'PUT #update' do
    context '[以下のとおり更新する]ボタンをクリックしたとき' do
      before do
        @id = 2
        @youtube = Youtube.find(@id)
        flash_hash = ActionDispatch::Flash::FlashHash.new
        flash_hash[:target_date_id] = 1
        flash_hash[:itune_id] = 1
        flash_hash[:running_ranking] = 2
        session['flash'] = flash_hash.to_session_value
        put :update, { id: @id \
                     , youtube: @youtube.attributes }
      end
      it 'ステータスコードとして302が返ること' do
        expect(response.status).to eq 302
      end
      it '@youtubeがnilでないこと' do
        expect(assigns(:youtube)).not_to be_nil
      end
      it 'flash[:target_date_id]がnilでないこと' do
        expect(flash[:target_date_id]).not_to be_nil
      end
      it 'flash[:itune_id]がnilでないこと' do
        expect(flash[:itune_id]).not_to be_nil
      end
      it 'flash[:running_ranking]がnilでないこと' do
        expect(flash[:running_ranking]).not_to be_nil
      end
    end
  end
end
