class SimpleCalendar::BookingCalendar < SimpleCalendar::Calendar
  private

  def date_range
    # Asegúrate de que @start_date y @end_date estén disponibles
    (options[:start_date]..options[:end_date]).to_a
  end
end
