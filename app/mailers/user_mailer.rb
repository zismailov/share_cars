class UserMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  def trip_confirmation(trip)
    @trip = trip
    mail(to: @trip.email, subject: "[Free Carpool] Validation of your ad")
  end

  def trip_information(trip)
    @trip = trip
    mail(to: @trip.email, subject: "[Free Carpool] Manage your ad")
  end

  def message_received_notification(message)
    @message = message
    @trip = message.trip
    mail(to: @trip.email, subject: "[Free Carpool] You have received a message")
  end

  def message_sent_notification(message)
    @message = message
    @trip = message.trip
    mail(to: @message.sender_email, subject: "[Free Carpool] You sent a message")
  end
end
