class ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    byebug
    if @listing.save

      redirect_to '/listings'
    else
      render root_path
    end
  end

  def edit
    @listing = Listing.find(params[:id])

  end

  def update
    @listing = Listing.find(params[:id])

    byebug
    if @listing.update_attributes(listing_params)
      redirect_to action: 'show', id: @listing.id
    else
      render action: 'edit'
    end
  end

  def delete
    listing = Listing.find(params[:id]).destroy
    redirect_to action: 'index'
  end


  private
  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :phone, :num_bedrooms, :price, :currency, :house_rules)
  end



end
