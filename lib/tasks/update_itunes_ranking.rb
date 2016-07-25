require 'rss'
require 'net/http'
require 'uri'
require 'json'

API_KEY = Rails.application.secrets.youtube_api_key
ARI_DOMAIN = 'www.googleapis.com'
API_SSL_PORT = 443

class Tasks::UpdateItunesRanking
	def self.execute

		# 日付マスタの更新
		update_mstdate()

		# iTunes RSSへ接続
		MstGenre.pluck(:itunes_url, :id) .each do |value|
			# RSSをパースする
			begin
				rss = RSS::Parser.parse(value[0], true)
			rescue RSS::Error
			end
			# ランキング順位初期化
			ranking = 0
			# 要素の取得
			rss.items.each do |item|
				# タグの中身([title] - [artist])を取得
				titile_artist = String(item.title).gsub(/<(".*?"|'.*?'|[^'"])*?>/, "").encode("UTF-8")
				# titleとartistの分離
				artist = titile_artist.gsub(/^.*-\s/,"")
				title = titile_artist.gsub(/\s-.*$/,"")
				# 曲マスタの更新
				update_mstmusic(artist, title)
				# ランキングテーブルの更新
				rank = Rank.new
				rank.rank = ranking +=1
				rank.mst_date_id = MstDate.maximum('id')
				rank.mst_genre_id = value[1]
				begin
					result = MstMusic.where(artist: artist, title: title).pluck(:id)
					rank.mst_music_id = result[0]
				rescue NoMethodError
					rank.mst_music_id = nil
				end
				rank.save
			end
		end
	end

    # 日付マスタの更新
	def self.update_mstdate()
		day = MstDate.new
		today = Date.today
		day.this_date = today
		day.save
	end

	# 曲マスタの更新
	def self.update_mstmusic(artist, title)
		# 曲マスタに存在しない場合、新規登録
		if MstMusic.find_by(artist: artist, title: title) == nil
			music = MstMusic.new
			music.artist = artist
			music.title = title
			music.youtube_url = get_youtube_uri(artist, title)
			music.save
		end
	end

	# youtubeのURIを取得
	def self.get_youtube_uri(artist, title)
		https = Net::HTTP.new(ARI_DOMAIN, API_SSL_PORT)
		https.use_ssl = true
		https.verify_mode = OpenSSL::SSL::VERIFY_PEER
		res = https.request_get('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=' + artist.gsub(" ", "%20") + '%20' + title.gsub(" ", "%20") + '&key=' + API_KEY) 
		result = JSON.parse(res.body)
		begin
			return result['items'][0]['id']['videoId']
		rescue NoMethodError
			return nil
		end
	end
end
