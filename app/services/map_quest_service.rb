class MapQuestService
  class << self
    def trip_duration_db(start_point, end_point, route_type)
      response = conn.get("/directions/v2/route") do |r|
        r.params['from']        = start_point
        r.params['to']          = end_point
        r.params['routeType']   = route_type
      end 
      time_string = parse_json(response)[:route][:formattedTime]
      secs = Time.parse(time_string).seconds_since_midnight
      mins = (secs / 60).round(0)
      mins_text = "#{mins} mins"

      return { eta: mins, eta_string: mins_text }
    end

    private

    def conn
      Faraday.new("http://www.mapquestapi.com") do |f|
          f.params['key'] = ENV['map_api_key']
      end
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end