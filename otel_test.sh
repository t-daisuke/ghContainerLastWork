# podの名前をよしなにしてください。これでotelにデータが送信されるか確認します。
# example
# Note: Unnecessary use of -X or --request, POST is already inferred.
# *   Trying 172.20.65.246:4318...
# * Connected to otel-collector-opentelemetry-collector.monitoring.svc.cluster.local (172.20.65.246) port 4318 (#0)
# > POST /v1/traces HTTP/1.1
# > Host: otel-collector-opentelemetry-collector.monitoring.svc.cluster.local:4318
# > User-Agent: curl/7.88.1
# > Accept: */*
# > Content-Type: application/json
# > Content-Length: 19
# > 
# < HTTP/1.1 200 OK
# < Content-Type: application/json
# < Date: Tue, 02 Jul 2024 03:20:41 GMT
# < Content-Length: 21
# < 
# * Connection #0 to host otel-collector-opentelemetry-collector.monitoring.svc.cluster.local left intact
# {"partialSuccess":{}}%      
k exec -it service-a-deployment-7cc9966776-hlljz -n doskoi -- curl -v -X POST http://otel-collector-opentelemetry-collector.monitoring.svc.cluster.local:4318/v1/traces \
     -H "Content-Type: application/json" \
     -d '{"example": "data"}'