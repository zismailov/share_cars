class Search
  include ActiveModel::Model

  attr_accessor(
    :from_city,
    :from_lon,
    :from_lat,
    :to_city,
    :to_lon,
    :to_lat,
    :date
  )

  validates_presence_of :from_city, :from_lon, :from_lat, :to_city, :to_lon, :to_lat, :date

  validate :dont_search_the_past

  def date_value
    Date.strptime(date, "%d/%m/%Y") if date.present?
  end

  private

  def dont_search_the_past
    errors.add(:date, "can not be in the past") if date.present? && date_value < Date.today
  end
end
