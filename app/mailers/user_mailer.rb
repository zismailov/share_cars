class UserMailer < ApplicationMailer
  def trip_information(trip)
    @trip = trip
    mail(to: @trip.email, subject: "[Free Carpool] Information about your ad")
  end

  def message_notification(message)
    @message = message
    @trip = message.trip
    mail(to: @trip.email, subject: "[Free Carpool] You have received a message for your ad")
  end
end
