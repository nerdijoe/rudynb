class ReservationsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_param)
    @reservation.listing = @listing

    if @reservation.save
      redirect_to listing_path(@listing)
    else
      # @errors = @reservation.errors.full_messages
      redirect_to listing_path(@listing), alert: @reservation.errors.full_messages
    end

  end


  def destroy
  end

  def show
    @reservations = current_user.reservations
  end


  private
  def reservation_param
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end


end