require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis =
    if ENV['REDIS_SENTINEL_SERVICE'].nil?
      { url: (ENV['REDIS_URL'] || 'redis://redis') }
    else
      {
        url: (ENV['REDIS_URL'] || 'redis://mymaster'),
        sentinels: [{ host: ENV['REDIS_SENTINEL_SERVICE'], port: '26379' }]
      }
    end
end

require 'set'
require 'sidekiq/web'
run Sidekiq::Web
