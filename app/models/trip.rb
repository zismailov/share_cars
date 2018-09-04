# require "elasticsearch/model"

class Trip < ApplicationRecord
  # include Searchable

  # use of this classification https://en.wikipedia.org/wiki/Hotel_rating
  CAR_RATINGS = %w[standard comfort first_class luxury].freeze
  STATES = %w[pending confirmed deleted].freeze

  has_many :points, inverse_of: :trip, dependent: :destroy
  has_many :messages

  has_secure_token :confirmation_token
  has_secure_token :edition_token
  has_secure_token :deletion_token

  accepts_nested_attributes_for :points, reject_if: proc { |attrs| attrs[:location_name].blank? && attrs[:kind] == "Step" }

  validates_presence_of :departure_date, :departure_time, :price, :description, :title, :name, :age, :phone, :email, :seats, :comfort, :state
  validates_inclusion_of :smoking, in: [true, false]
  validates_inclusion_of :comfort, in: CAR_RATINGS
  validates_inclusion_of :state, in: STATES
  validates_numericality_of :price, :age, :seats
  validate :must_have_from_and_to_points

  after_create :send_information_email

  # eager load points each time a trip is requested
  default_scope { includes(:points).order("created_at ASC") }

  # access the departure point that comes eager loaded with a trip
  def point_from
    points.find { |point| point.kind == "From" }
  end

  # access the destination point that comes eager loaded with a trip
  def point_to
    points.find { |point| point.kind == "To" }
  end

  # access the steps point that comes eager loaded with a trip
  def step_points
    points.select { |point| point.kind == "Step" }
  end

  def confirm!
    update_attribute(:state, "confirmed")
  end

  def soft_delete!
    update_attribute(:state, "deleted")
  end

  def confirmed?
    state == "confirmed"
  end

  class << self
    def search(options = {})
      options ||= {}
      # empty search not allowed, for now
      return nil if options.blank?
      sql_query_string = <<-SQL
          select trip_point_a.id, departure_date, point_a_rank as from_rank, rank as to_rank
          from (
          select trips.id, departure_date, points.rank as point_a_rank
          from trips
          inner join points on points.trip_id = trips.id
          where state = 'confirmed'
          and
            ST_Dwithin(
              ST_GeographyFromText('SRID=4326;POINT(' || points.lon || ' ' || points.lat || ')'),
              ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
              10000
            )
          ) as trip_point_a
          inner join points on points.trip_id = trip_point_a.id
          where
            ST_Dwithin(
              ST_GeographyFromText('SRID=4326;POINT(' || points.lon || ' ' || points.lat || ')'),
              ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
              10000
            )
          and point_a_rank < points.rank
          order by departure_date asc
      SQL
      Trip.find_by_sql([
                         sql_query_string,
                         options[:from_coordinates][:lon],
                         options[:from_coordinates][:lat],
                         options[:to_coordinates][:lon],
                         options[:to_coordinates][:lat]
                       ])
  end
 end

  private

  def must_have_from_and_to_points
    if points.empty? || point_from.nil? || point_to.nil?
      errors.add(:base, "Departure and arrival of the trip are necessary")
    end
  end

  def send_information_email
    UserMailer.trip_information(self).deliver_now
  end
end
