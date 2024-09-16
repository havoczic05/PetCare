class SimpleCalendar::BookingCalendar < SimpleCalendar::Calendar
  private

  def date_range
    beginning = @booking.start_date
    ending = @booking.end_date
    (beginning..ending).to_a
  end
end
