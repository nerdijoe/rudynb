class ReservationsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_param)
    @reservation.listing = @listing

    if @reservation.save
      # ReservationMailer.booking_email(current_user, @listing.user, @reservation.id).deliver_now

      # ReservationMailer.booking_email(current_user, @listing.user, @reservation.id).deliver_later(wait: 1.minute)

      ReservationJob.perform_later(current_user, @listing.user, @reservation.id)

      # ReservationJob.perform_in(1.minute, current_user, @listing.user, @reservation.id)

      # ReservationMailer.delay_for(1.minute).booking_email(current_user, @listing.user, @reservation.id)

      redirect_to listing_path(@listing)
    else
      @errors = @reservation.errors.full_messages
      render 'listings/show'
    end

  end

  def destroy
  end

  def user_reservations
    # can only see his own reservations
    @reservations = current_user.reservations
  end


  private
  def reservation_param
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end


end
