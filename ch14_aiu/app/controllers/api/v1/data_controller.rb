require 'net/http'

class Api::V1::DataController < ApplicationController
  def send_data
    uri = URI('http://service_b:3001/api/v1/data/receive')
    response = Net::HTTP.get(uri)
    render json: { response: response }, status: :ok
  end
end
