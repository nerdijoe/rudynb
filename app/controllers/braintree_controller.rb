class BraintreeController < ApplicationController
  def new
    # calculate amount
    byebug
    @reservation = Reservation.find(params[:id])
    @amount = (@reservation.end_date.mjd - @reservation.start_date.mjd) * @reservation.listing.price
    byebug
    @client_token = Braintree::ClientToken.generate
  end



end
