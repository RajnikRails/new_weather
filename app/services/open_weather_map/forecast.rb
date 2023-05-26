require 'httparty'

module OpenWeatherMap
  class Forecast
    BASE_URL = 'https://api.openweathermap.org/data/2.5'

    def initialize(api_key)
      @api_key = api_key
    end

    def forecast(city)
      @city = city
      HTTParty.get("#{BASE_URL}/forecast?lat=#{lat}&lon=#{lon}&appid=#{@api_key}")
    end

    private

    def lat
      geocoded_city_response&.first&.dig('lat')
    end

    def lon
      geocoded_city_response&.first&.dig('lon')
    end

    def geocoded_city_response
      @geocoded_city_response ||= Geocode.new(@api_key).geocode(@city)
    end
  end
end
