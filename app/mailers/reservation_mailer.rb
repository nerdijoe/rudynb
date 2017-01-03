class ReservationMailer < ApplicationMailer
  default from: "rudynb.app@gmail.com"

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation = Reservation.find(reservation_id)

    mail(to: @host.email, subject: 'Yay, someone has made reservation to your listing!')
  end

end
