class MessageInfo
  attr_reader :mobile_number, :message

  def initialize(data)
    @mobile_number = set_mobile_number(data[:mobile_number])
    @message = set_message(data[:message])
  end

  def set_mobile_number(number)
    if number == ""
      nil
    else 
      number
    end
  end

  def set_message(message)
    if message == ""
      nil
    else 
      message
    end
  end
end
