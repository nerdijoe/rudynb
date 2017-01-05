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

    result = Braintree::Transaction.sale(
      :amount => get_amount(params[:reservation_id]),
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )

    byebug
    if result.success?

      #update reservation status to paid
      @reservation = Reservation.find(params[:reservation_id])
      # @reservation.paid = true
      # @reservation.save
      @reservation.update(paid: true)

      byebug

      #insert success transaction to payments table
      @payment = Payment.new(
      cardholder_name: params[:checkout_form][:cardholder_name], billing_address: params[:checkout_form][:billing_address], billing_postal_code: params[:checkout_form][:billing_postal_code], transaction_id: result.transaction.id,
      card_type: result.transaction.credit_card_details.card_type,
      amount: result.transaction.amount
        )
      @payment.reservation_id = params[:reservation_id]
      @payment.save

      byebug

      redirect_to user_reservations_path(current_user), :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end

  private
  def payment_params
    params.require(:payment).permit(:transaction_id, :amount, :card_type, :cardholder_name, :billing_address, :billing_postal_code, :reservation_id)
  end

  def get_amount(reservation_id)
    reservation = Reservation.find(reservation_id)
    (reservation.end_date.mjd - reservation.start_date.mjd) * reservation.listing.price
  end



end
