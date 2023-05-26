# app/controllers/weather_controller.rb
class WeatherController < ApplicationController
  def index
  end

  def forecast
    api_key = Rails.application.credentials.open_weather_map[:api_key]
    service = OpenWeatherMap::Forecast.new(api_key)
    response = service.forecast(params[:city])
    @forecast = response.parsed_response['list']
    @date_forecast, @current_weather = RetriveWeatherInfo.new(@forecast).call
    if @forecast
      render :forecast
    else
      render :index
    end
  end
end

