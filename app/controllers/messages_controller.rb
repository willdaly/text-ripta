class MessagesController < ApplicationController

    def reply
      sms = twilio.send_message(params["From"], message(params["Body"]))
    end

    private

    def twilio
      TwilioService.new
    end

    def message posted_text
      Message.new(posted_text).text
    end

end
