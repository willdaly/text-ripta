class TwilioService
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new Rails.application.secrets.account_sid, Rails.application.secrets.auth_token
  end

  def send_message(to, message)
    client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: to,
      body: message
    )
  end

end
