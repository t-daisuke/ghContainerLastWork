require 'net/http'

class Api::V1::DataController < ApplicationController
  def send_data
    # 環境変数でlocalがk8sかで分岐
    allowed_host = ENV['ALLOWED_HOST']
    uri = URI("http://#{allowed_host}:3001/api/v1/data/receive")
    response = Net::HTTP.get(uri)
    render json: { response: response }, status: :ok
  end
end
