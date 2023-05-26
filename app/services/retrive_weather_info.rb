class RetriveWeatherInfo

    def initialize(forecast)
      @forecast = forecast
    end

    def call
      date_forecast = []
      current_weather = @forecast.min_by{|data| data["dt_txt"].to_date }
      forecast_by_date = @forecast.group_by { |date| date["dt_txt"].to_date }
      forecast_by_date.each do |date, data|
        data = data.minmax{|a, b| a.dig("main", "temp_min") <=> b.dig("main", "temp_max")}
        min_row = data.first
        max_row = data.second
        date_forecast << {
            dt_txt: max_row["dt_txt"].to_date == Date.today ? 'Today' : max_row["dt_txt"].to_date.strftime("%A"),
            temp_max: max_row["main"]["temp_max"],
            temp_min: min_row.dig("main", "temp_min"),
            weather: max_row['weather'].first['description'].capitalize
        }
      end
      [date_forecast, current_weather]
    end

end