class Point < ApplicationRecord
  KINDS = %w[From Step To].freeze

  belongs_to :trip, inverse_of: :points

  validates_presence_of :kind, :rank, :trip, :lat, :lon, :city
  validates_inclusion_of :kind, in: KINDS
  validates_numericality_of :rank
  validate :lat_lon_must_be_set

  before_validation :set_from_rank, :set_to_rank

  private

  def lat_lon_must_be_set
    errors.add(:city, "You must select a city from the list") if lat.blank? || lon.blank?
  end

  def set_from_rank
    self.rank = 0 if kind == "From"
  end

  def set_to_rank
    self.rank = 99 if kind == "To"
  end
end
