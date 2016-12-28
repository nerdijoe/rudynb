class ListingsController < ApplicationController
  before_action :authorize, only: :edit

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(10)
    else
      @listings = Listing.all.page(params[:page]).per_page(10)
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

    # byebug
    if @listing.update_attributes(listing_params)
      redirect_to action: 'show', id: @listing.id
    else
      render action: 'edit'
    end
  end

  def destroy
    listing = Listing.find(params[:id]).destroy
    redirect_to action: 'index'
  end




  private
  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :phone, :num_bedrooms, :price, :currency, :house_rules, :tag_list)
  end

  def authorize
    if current_user.customer?
      redirect_to listings_path, alert: "Not authorized"
    end
  end



end
