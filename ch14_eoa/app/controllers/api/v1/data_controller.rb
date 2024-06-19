# app/controllers/api/v1/data_controller.rb
class Api::V1::DataController < ApplicationController
  def receive
    port = request.port
    render json: { message: 'Data received via GET', port: port }, status: :ok
  end
end
