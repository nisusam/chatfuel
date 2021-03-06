class TicketDecorator
  attr_reader :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  delegate :status, :description, to: :klazz
  delegate_missing_to :ticket

  private

  def klazz
    @klazz ||= "#{ticket.status}_status".classify.constantize
    @klazz.new(self)
  end
end
