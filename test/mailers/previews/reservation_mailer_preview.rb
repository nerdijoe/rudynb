# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def booking_email_preview
    ReservationMailer.booking_email(User.find(2), User.find(1), 6)
  end
end
