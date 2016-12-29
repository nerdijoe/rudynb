class ListingsController < ApplicationController
  before_action :authorize

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag]).order(created_at: :asc).page(params[:page]).per_page(10)
    else
      @listings = Listing.all.order(created_at: :asc).page(params[:page]).per_page(10)
    end
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
    # @listing.tag_list = listing_params[:tag_list].split(',')

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
    if @listing.update_attributes(listing_params)
      redirect_to action: 'show', id: @listing.id
    else
      # render action: 'edit'
      redirect_to listing_path(@listing), alert: "System error, cannot update your listing"
    end

  end

  def destroy
    Listing.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  def verify
    @listing = Listing.find(params[:id])
    @listing.verified ^= true
    @listing.save

    # redirect_to action: 'show', id: @listing.id
    redirect_to listing_path(@listing)
  end

  def upload_photos
    @listing = Listing.find(params[:id])

  end


  private
  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :phone, :num_bedrooms, :price, :currency, :house_rules, :tag_list, :verified, {photos: []})
  end



end
