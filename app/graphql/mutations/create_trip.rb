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
    eta = EtaService.get_eta(start_point, end_point, travel_mode)

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

