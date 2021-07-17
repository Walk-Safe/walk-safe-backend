class Message
  attr_reader :mobile_number, :message

  def initialize(data)
    @mobile_number = data[:mobile_number]
    @message = data[:message]
  end
end
