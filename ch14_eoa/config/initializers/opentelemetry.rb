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
  c.use_all # すべてのインストルメンテーションを自動的に使用

  # OTLPエクスポーターの設定
  c.service_name = 'your-service-name'
  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: 'http://localhost:4317' # エンドポイントを適切に設定
      )
    )
  )
end
