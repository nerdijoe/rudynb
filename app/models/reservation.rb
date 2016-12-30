class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validate :check_max_guests
  validate :check_overlapping_dates

  def check_max_guests
    if num_guests <= listing.max_guests
      return true
    else
      errors.add(:max_guests, "Number of guests exceeded")
    end
  end

  def check_overlapping_dates

    listing.reservations.each do |old_reservation|
      if overlap?(self, old_reservation)
        return errors.add(:overlapping_dates, "Conflicting dates with existing reservations")
      end
    end

    return true
  end

  def overlap?(x,y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end


end
