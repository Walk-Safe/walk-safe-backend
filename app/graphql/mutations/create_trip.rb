class Mutations::CreateTrip < Mutations::BaseMutation
  argument :start_point, String, required: true
  argument :end_point, String, required: true
  argument :travel_mode, String, required: true
  argument :eta, Integer, required: false
  argument :eta_string, String, required: false
  argument :user_id, Integer, required: true

  field :trip, Types::TripType, null: false
  field :errors, [String], null: false

  def resolve(start_point:, end_point:, travel_mode:, user_id:)
    eta_data = EtaService.get_eta(start_point, end_point, travel_mode)
    check_for_error(eta_data[:eta], eta_data[:eta_string])

    trip = User.find(user_id).trips.new(
      start_point: start_point,
      end_point:   end_point,
      travel_mode: travel_mode,
      eta:         eta_data[:eta],
      eta_string:  eta_data[:eta_string]
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

  def check_for_error(eta, eta_string)
    if eta.nil? || eta_string.nil?
      raise GraphQL::ExecutionError, "Invalid address, please try again"
    end
  end
end
