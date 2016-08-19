require 'rss'
require 'net/http'
require 'uri'
require 'json'

API_KEY = Rails.application.secrets.youtube_api_key
ARI_DOMAIN = 'www.googleapis.com'
API_SSL_PORT = 443

class Tasks::UpdateDailyRanking
	def self.execute

		# 日付マスタの更新
		update_aggregate_dates()

		# iTunes RSSへ接続
		Itune.pluck(:itunes_url, :itune_id) .each do |value|
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
				update_youtubes(artist, title)
				# ランキングテーブルの更新
				rank = DailyRanking.new
				rank.rank = ranking +=1
				rank.aggregate_date_id = AggregateDate.maximum('aggregate_date_id')
				rank.itune_id = value[1]
				begin
					result = Youtube.where(artist: artist, title: title).pluck(:youtube_id)
					rank.youtube_id = result[0]
				rescue NoMethodError
					rank.youtube_id = nil
				end
				rank.save
			end
		end
	end

    # 日付マスタの更新
	def self.update_aggregate_dates()
		day = AggregateDate.new
		today = Date.today
		day.this_date = today
		day.save
	end

	# 曲マスタの更新
	def self.update_youtubes(artist, title)
		# 曲マスタに存在しない場合、新規登録
		if Youtube.find_by(artist: artist, title: title) == nil
			music = Youtube.new
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
