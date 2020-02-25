class MessengerService
  def self.notify(completed)
    completed.find_each do |ticket|
      # RestClient.post url, params(ticket)
      ticket.notified!
      p 'notified'
    end
  end

  private

  def url
    host = 'https://graph.facebook.com'
    path = 'v6.0/me/messages'
    token = ENV['FB_PAGE_TOKEN']

    @url ||= "#{host}/#{path}?access_token=#{token}"
  end

  def params(ticket)
    {
      message_type: 'RESPONSE',
      recipient: {
        id: ticket.message.session_id
      },
      message: {
        text: "#{ticket.code} is completed!"
      }
    }
  end
end
