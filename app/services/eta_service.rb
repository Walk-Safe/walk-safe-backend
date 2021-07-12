class EtaService
  class << self
    def get_eta(start_point, end_point, travel_mode)
      response = conn.get('maps/api/distancematrix/json') do |f|
        f.params['units']        = 'imperial'
        f.params['origins']      = start_point
        f.params['destinations'] = end_point
        f.params['mode']         = travel_mode
      end

      sec = parse_json(response)[:rows][0][:elements][0][:duration][:value]
      min = (sec.to_f / 60).round(0)
    end

    private

    def conn
      conn = Faraday.new('https://maps.googleapis.com/') do |f|
        f.params['key'] = ENV['google_api_key']
      end
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end