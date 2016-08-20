require 'rss'
require 'net/http'
require 'uri'
require 'json'

API_KEY = Rails.application.secrets.youtube_api_key
API_DOMAIN = 'www.googleapis.com'
API_PATH = '/youtube/v3/search'
API_URI = 'https://' + API_DOMAIN + API_PATH + '?part=snippet&maxResults=1&q='
API_SSL_PORT = 443
API_KEY.freeze
API_DOMAIN.freeze
API_PATH.freeze
API_URI.freeze
API_SSL_PORT.freeze

# batch
module Tasks
  class UpdateDailyRanking
    def self.execute
      update_aggregate_dates
      Itune.pluck(:itunes_url, :itune_id) .each do |value|
        begin
          rss = RSS::Parser.parse(value[0], true)
        rescue => e
          logger.fatal e.backtrace.join("\n")
        end
        ranking = 0
        rss.items.each do |item|
          titile_artist = String(item.title) \
                          .gsub(/<('.*?'|'.*?'|[^''])*?>/, '').encode('UTF-8')
          artist = titile_artist.gsub(/^.*-\s/, '')
          title = titile_artist.gsub(/\s-.*$/, '')
          update_youtubes(artist, title)
          rank = DailyRanking.new
          rank.rank = ranking += 1
          rank.aggregate_date_id = AggregateDate.maximum('aggregate_date_id')
          rank.itune_id = value[1]
          begin
            result = Youtube.where(artist: artist, title: title) \
                            .pluck(:youtube_id)
            rank.youtube_id = result[0]
          rescue NoMethodError
            rank.youtube_id = nil
          end
          rank.save
        end
      end
    end

    def self.update_aggregate_dates
      day = AggregateDate.new
      today = Date.today
      day.this_date = today
      day.save
    end

    def self.update_youtubes(artist, title)
      if Youtube.find_by(artist: artist, title: title).nil?
        music = Youtube.new
        music.artist = artist
        music.title = title
        music.youtube_url = get_youtube_uri(artist, title)
        music.save
      end
    end

    def self.get_youtube_uri(artist, title)
      https = Net::HTTP.new(API_DOMAIN, API_SSL_PORT)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      uri = API_URI + artist.gsub(' ', '%20') + '%20' + title.gsub(' ', '%20') \
              + '&key=' + API_KEY
      res = https.request_get(uri)
      result = JSON.parse(res.body)
      begin
        return result['items'][0]['id']['videoId']
      rescue NoMethodError
        return nil
      end
    end
  end
end
