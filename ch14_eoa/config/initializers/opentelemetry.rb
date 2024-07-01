# config/initializers/opentelemetry.rb

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/rack'
require 'opentelemetry/instrumentation/active_record'
require 'opentelemetry/instrumentation/action_pack'
require 'opentelemetry/instrumentation/action_view'
require 'opentelemetry/instrumentation/active_support'

# SDKの設定
OpenTelemetry::SDK.configure do |c|
  # インストルメンテーションの設定
  c.use 'OpenTelemetry::Instrumentation::Rack'
  c.use 'OpenTelemetry::Instrumentation::ActiveRecord'
  c.use 'OpenTelemetry::Instrumentation::ActionPack'
  c.use 'OpenTelemetry::Instrumentation::ActionView'
  c.use 'OpenTelemetry::Instrumentation::ActiveSupport'

  # OTLPエクスポーターの設定
  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: ENV['OTEL_EXPORTER_OTLP_ENDPOINT']
      )
    )
  )
end
