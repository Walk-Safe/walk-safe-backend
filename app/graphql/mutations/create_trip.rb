class Mutations::CreateTrip < Mutations::BaseMutation
  argument :start_point, String, required: true
  argument :end_point, String, required: true
  argument :travel_mode, String, required: true
  argument :start_lat, String, required: false
  argument :start_lon, String, required: false
  argument :end_lat, String, required: false
  argument :end_lon, String, required: false
  argument :eta, Integer, required: false
  argument :user_id, Integer, required: true

  field :trip, Types::TripType, null: false
  field :errors, [String], null: false

  def resolve(start_point:, end_point:, travel_mode:, start_lat:, start_lon:, end_lat:, end_lon:, eta:, user_id:)
    # require 'pry'; binding.pry

    # start_point = '4735 Orchard Pkwy Westminster CO'
    # end_point   = '11815 Ridge Pkwy Broomfield CO'
    travel_mode = 'walking'
    
    conn = Faraday.new('https://maps.googleapis.com/') do |f|
      f.params['key'] = ENV['google_api_key']
    end

    response = conn.get('maps/api/distancematrix/json') do |f|
      f.params['units']        = 'imperial'
      f.params['origins']      = start_point
      f.params['destinations'] = end_point
      f.params['mode']         = travel_mode
    end

    data = JSON.parse(response.body, symbolize_names: true)
    # eta in seconds
    eta = data[:rows][0][:elements][0][:duration][:value]

    trip = User.find(user_id).trips.new(
                start_point: start_point,
                end_point:   end_point,
                travel_mode: travel_mode,
                # start_lat:   start_lat,
                # start_lon:   start_lon,
                # end_lat:     end_lat,
                # end_lon:     end_lon,
                eta:         eta
      )
  
    if trip.save
      {
        trip: trip, 
        errors: []
      }
    else 
      {
        trip: nil,
        errors: trip.errors.full_messages
      }
    end

  end
end

