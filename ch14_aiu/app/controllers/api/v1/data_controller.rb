require 'net/http'

class Api::V1::DataController < ApplicationController
  def send_data
    # 環境変数でlocalがk8sかで分岐
    uri = URI('http://service-b-service.doskoi.svc.cluster.local:3001/api/v1/data/receive')
    response = Net::HTTP.get(uri)
    render json: { response: response }, status: :ok
  end
end
