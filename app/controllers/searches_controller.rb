class SearchesController < ApplicationController

  def new
    @search = Search.new
    @cities = Listing.uniq.pluck(:city)

  end

  def create
    @search = Search.create(search_params)
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])

    @listings = Listing.all.order(created_at: :asc).page(params[:page]).per_page(10)
    @listings = @listings.search_by_keyword(@search.keyword) if @search.keyword.present?
    @listings = @listings.city(@search.city) if @search.city.present?
    @listings = @listings.num_bedrooms(@search.num_bedrooms) if @search.num_bedrooms.present?
    @listings = @listings.num_guests(@search.num_guests) if @search.num_guests.present?
    @listings = @listings.min_price(@search.min_price) if @search.min_price.present?
    @listings = @listings.max_price(@search.max_price) if @search.max_price.present?

  end

  private
  def search_params
    params.require(:search).permit(:keyword, :city, :country, :min_price, :max_price, :num_bedrooms, :num_guests)
  end

end
