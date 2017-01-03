class PaymentsController < ApplicationController
  def new
    # calculate amount

    @reservation = Reservation.find(params[:reservation_id])
    @days = @reservation.end_date.mjd - @reservation.start_date.mjd
    @amount = @days * @reservation.listing.price
    @client_token = Braintree::ClientToken.generate
  end

  def create
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    byebug
    result = Braintree::Transaction.sale(
      :amount => get_amount(params[:reservation_id]),
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )
    byebug
    if result.success?
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end

  private
  def get_amount(reservation_id)
    reservation = Reservation.find(reservation_id)
    (reservation.end_date.mjd - reservation.start_date.mjd) * reservation.listing.price

  end

end
