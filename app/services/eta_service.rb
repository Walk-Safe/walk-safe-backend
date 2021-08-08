class EtaService
  class << self
    def get_eta(start_point, end_point, travel_mode)
      begin
        response = conn.get('maps/api/distancematrix/json') do |f|
          f.params['units']        = 'imperial'
          f.params['origins']      = start_point
          f.params['destinations'] = end_point
          f.params['mode']         = travel_mode
        end
        seconds = parse_json(response)[:rows][0][:elements][0][:duration][:value]
        minutes = (seconds.to_f / 60).round(0)
        minutes_text = parse_json(response)[:rows][0][:elements][0][:duration][:text]
        
        return { eta: minutes, eta_string: minutes_text }
      rescue
        if travel_mode == "driving"
          route_type = "fastest"
        elsif travel_mode == "walking"
          route_type = "pedestrian"
        elsif travel_mode == "bicycling"
          route_type = "bicycle"
        else
          route_type = nil
        end

        MapQuestService.trip_duration_db(start_point, end_point, route_type)
      rescue NoMethodError
        { eta: nil, eta_string: nil }
      end
    end

    private

    def conn
      Faraday.new('https://maps.googleapis.com/') do |f|
        f.params['key'] = ENV['google_api_key']
      end
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
