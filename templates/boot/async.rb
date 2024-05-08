require "foobara/resque_connector"

redis_url = ENV.fetch("REDIS_URL", nil)

unless redis_url
  # :nocov:
  raise NoRedisUrlError, 'Must set ENV["REDIS_URL"] if trying to initialize ResqueConnector with no arguments'
  # :nocov:
end

Resque.redis = Redis.new(url: redis_url)

resque_connector = Foobara::CommandConnectors::ResqueConnector.new

# resque_connector.connect(SomeCommandOrDomainOrOrganization)

RESQUE_CONNECTOR = resque_connector
