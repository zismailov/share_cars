class TripsController < ApplicationController
  before_action :load_trip, only: %i[show update]

  def index
    params.permit!
    @trips = Trip.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    unless @trip.confirmed?
      flash[:notice] = "Your ad is saved but not yet published. We sent you a confirmation email to validate your ad."
    end
  end

  def new
    @trip = Trip.new
    point_from = @trip.points.build(kind: "From")
    point_to = @trip.points.build(kind: "To")
    @required_points = [point_from, point_to]
    @optional_points = build_three_step_points
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Your ad is saved but not yet published. We have sent you a confirmation email to validate your ad."
    else
      point_from = @trip.point_from || @trip.points.build(kind: "From")
      point_to = @trip.point_to || @trip.points.build(kind: "To")
      @required_points = [point_from, point_to]
      @optional_points = @trip.step_points.empty? ? build_three_step_points : @trip.step_points
      render :new
    end
  end

  # caution, this is a modifying action reached by a GET method
  def confirm
    @trip = Trip.find_by(confirmation_token: params[:token])
    if @trip
      if @trip.confirm!
        redirect_to @trip, notice: "Your ad is published! Thank you for your contribution to the community!"
      else
        render :not_found # let's give no information on this error to the internet
      end
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def edit
    flash[:notice] = "You can edit your ad by updating the form below."
    @trip = Trip.find_by(edition_token: params[:token])
    if @trip
      render :edit
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def update
    if @trip.update_attributes(trip_params)
      redirect_to @trip, notice: "Your ad is up-to-date Thank you for your contribution to the community!"
    else
      point_from = @trip.point_from || @trip.points.build(kind: "From")
      point_to = @trip.point_to || @trip.points.build(kind: "To")
      @required_points = [point_from, point_to]
      @optional_points = @trip.step_points.empty? ? build_three_step_points : @trip.step_points
      render :new
    end
  end

  # caution, this is a destructive action reached by a GET method
  def delete
    @trip = Trip.find_by(deletion_token: params[:token])
    if @trip
      if @trip.soft_delete!
        render :show, notice: "Your ad is deleted. To cancel click here: <a href='/trips/@trip.id/confirm?confirmation_token: #{@trip.confirmation_token}'>Cancel</a>"
      else
        render :not_found # let's give no information on this error to the internet
      end
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  private

  def load_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:departure_date,
      :departure_time,
      :price,
      :description,
      :title,
      :name,
      :age,
      :phone,
      :email,
      :seats,
      :comfort,
      :smoking,
      points_attributes: %i[
        id kind rank city lon lat _destroy
      ])
  end

  def build_three_step_points
    three_step_points = []
    3.times do |i|
      three_step_points << @trip.points.build(kind: "Step", rank: (i + 1))
    end
    three_step_points
  end
end
