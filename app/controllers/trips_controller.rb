class TripsController < ApplicationController
  before_action :load_trip, only: [:show]

  def index; end

  def show; end

  def new
    @trip = Trip.new
    @point_from = @trip.points.build(kind: "From")
    @point_to = @trip.points.build(kind: "To")
    @required_points = [@point_from, @point_to]
    @optional_points = []
    3.times do |i|
      @optional_points << @trip.points.build(kind: "Step", rank: (i + 1))
    end
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Your ad is saved but not yet published. We have sent you a confirmation email to validate your ad."
    else
      @required_points = [@trip.point_from, @trip.point_to]
      @optional_points = @trip.step_points
      render :new
    end
  end

  def edit; end

  def update; end

  private

  def load_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:date, :hour, :kind, :leave_at, :hour, :price, :description, :title, :name, :age, :phone, :email,
      points_attributes: %i[
        id kind location_name location_coordinates _destroy
      ])
  end
end
