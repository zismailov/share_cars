class Point < ApplicationRecord
  KINDS = %w[From Step To].freeze

  belongs_to :trip, inverse_of: :points

  validates_presence_of :kind, :rank, :trip, :lat, :lon, :city
  validates_inclusion_of :kind, in: KINDS
  validates_numericality_of :rank

  before_validation :set_from_rank, :set_to_rank

  private

  def set_from_rank
    self.rank = 0 if kind == "From"
  end

  def set_to_rank
    self.rank = 99 if kind == "To"
  end
end
