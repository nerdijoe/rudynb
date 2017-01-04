class Search < ActiveRecord::Base

  def search_listings
    @listings = Listing.all
    byebug
    @listings = @listings.city(self.city)

    return @listings
  end
end
