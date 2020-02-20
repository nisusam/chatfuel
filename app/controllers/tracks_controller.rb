class TracksController < ApplicationController
  before_action :message

  def create
    @track = Track.new(track_params)

    if @track.save
      @site = Site.find_by(code: @track.site_code)
      @track.update(site: @site)

      @message = Message.find_by(content: message)
      @message.steps.create(act: 'tracking_ticket', track: @track)

      head :created
    end
  end

  private

  def message
    case params[:klass]
    when 'TextMessage' then TextMessage.find_by(messenger_user_id: params[:messenger_user_id])
    when 'VoiceMessage' then VoiceMessage.find_by(callsid: params[:callsid])
    end
  end

  def track_params
    params.require(:track).permit(:code)
  end
end
