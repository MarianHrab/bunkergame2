class OpenWeatherMapService
    include HTTParty
    base_uri 'http://api.openweathermap.org/data/2.5'
  
    def self.weather_for_city(city_name)
        response = get('/weather', query: { q: city_name, appid: '84995063f35ce23eb2bbbf5b82f16242' })
        response.parsed_response
      end
      
  end
  