class MessagesController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @message = @trip.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.js { render :create }
      end
    else
      respond_to do |format|
        format.js { render :errors }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender_name, :sender_email, :body)
  end
end
