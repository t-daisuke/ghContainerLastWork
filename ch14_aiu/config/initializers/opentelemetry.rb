# ch14_aiu/config/opentelemetry.rb
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'doskoi-service-a'
  c.use_all
end
